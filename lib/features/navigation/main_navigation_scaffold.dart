import 'package:flutter/material.dart';
import '../dashboard/presentation/dashboard_screen.dart';
import '../learning_path/presentation/learning_path_screen.dart';
import '../ai_teacher/presentation/ai_teacher_screen.dart';
import '../vocabulary/presentation/vocabulary_screen.dart';
import '../progress/presentation/progress_screen.dart';

class MainNavigationScaffold extends StatefulWidget {
  const MainNavigationScaffold({super.key});

  @override
  State<MainNavigationScaffold> createState() => _MainNavigationScaffoldState();
}

class _MainNavigationScaffoldState extends State<MainNavigationScaffold> {
  int _currentIndex = 0;

  void _onSelectTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      DashboardScreen(onNavigateTab: _onSelectTab),
      const LearningPathScreen(), // Tab 1: Lộ trình học 3 ngôn ngữ
      const AiTeacherScreen(isEmbedded: true), // Tab 2: Giáo viên AI
      const VocabularyScreen(), // Tab 3: Từ vựng & Flashcard FSRS
      const ProgressScreen(), // Tab 4: Tiến độ & Mục tiêu
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onSelectTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alt_route_outlined),
            activeIcon: Icon(Icons.alt_route),
            label: 'Lộ trình',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy_outlined),
            activeIcon: Icon(Icons.smart_toy),
            label: 'AI Teacher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.style_outlined),
            activeIcon: Icon(Icons.style),
            label: 'Từ vựng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights_outlined),
            activeIcon: Icon(Icons.insights),
            label: 'Tiến độ',
          ),
        ],
      ),
    );
  }
}

