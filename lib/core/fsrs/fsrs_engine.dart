import 'dart:math';

/// Free Spaced Repetition Scheduler (FSRS) Core Algorithm
/// Implements state transitions, stability & difficulty calculations, and interval scheduling.
enum FSRSRating { again, hard, good, easy }

class FSRSItemState {
  final double stability;
  final double difficulty;
  final int reps;
  final int lapses;
  final int state; // 0=New, 1=Learning, 2=Review, 3=Relearning
  final DateTime? lastReview;
  final DateTime nextReview;

  const FSRSItemState({
    required this.stability,
    required this.difficulty,
    required this.reps,
    required this.lapses,
    required this.state,
    this.lastReview,
    required this.nextReview,
  });

  factory FSRSItemState.initial() {
    return FSRSItemState(
      stability: 1.0,
      difficulty: 5.0,
      reps: 0,
      lapses: 0,
      state: 0,
      nextReview: DateTime.now(),
    );
  }
}

class FSRSEngine {
  static const double requestRetention = 0.90; // 90% retention rate target

  /// Calculate next review interval and updated state based on learner rating
  static FSRSItemState reviewItem(FSRSItemState current, FSRSRating rating) {
    final now = DateTime.now();
    double newDifficulty = current.difficulty;
    double newStability = current.stability;
    int newReps = current.reps + 1;
    int newLapses = current.lapses;
    int newState = current.state;

    // Map rating to 1..4
    final int grade = switch (rating) {
      FSRSRating.again => 1,
      FSRSRating.hard => 2,
      FSRSRating.good => 3,
      FSRSRating.easy => 4,
    };

    // Update difficulty: D' = D - w6 * (grade - 3)
    newDifficulty = current.difficulty - 0.7 * (grade - 3);
    newDifficulty = newDifficulty.clamp(1.0, 10.0);

    if (grade == 1) {
      // Failed review (Again)
      newLapses++;
      newState = 3; // Relearning
      newStability = max(0.5, current.stability * 0.4);
      return FSRSItemState(
        stability: newStability,
        difficulty: newDifficulty,
        reps: newReps,
        lapses: newLapses,
        state: newState,
        lastReview: now,
        nextReview: now.add(const Duration(minutes: 10)), // 10 minutes interval for immediate recall
      );
    } else {
      // Passed review (Hard, Good, Easy)
      newState = 2; // Review state
      final double gradeMultiplier = switch (rating) {
        FSRSRating.hard => 1.2,
        FSRSRating.good => 2.5,
        FSRSRating.easy => 3.8,
        _ => 1.0,
      };

      newStability = current.stability * gradeMultiplier * (1.0 + (10.0 - newDifficulty) / 10.0);

      // Interval I = S * 9 * (1/retention - 1)
      final double rawDays = newStability * (1.0 / requestRetention - 1.0) * 10;
      final int scheduledDays = max(1, rawDays.round());

      return FSRSItemState(
        stability: newStability,
        difficulty: newDifficulty,
        reps: newReps,
        lapses: newLapses,
        state: newState,
        lastReview: now,
        nextReview: now.add(Duration(days: scheduledDays)),
      );
    }
  }
}
