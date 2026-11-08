-- ==============================================================================
-- PERSONAL AI LANGUAGE COACH (EN - JA - ZH)
-- SUPABASE / POSTGRESQL INITIAL SCHEMA
-- Contains 23 tables matching the User Requirements Specification (URS) v1.0
-- ==============================================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ------------------------------------------------------------------------------
-- 1. USERS & PROFILES
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.users (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT UNIQUE NOT NULL,
    display_name TEXT NOT NULL,
    native_language VARCHAR(5) DEFAULT 'vi',
    daily_study_target_minutes INT DEFAULT 30,
    preferred_study_time VARCHAR(20) DEFAULT 'evening', -- 'morning', 'afternoon', 'evening'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 2. USER LANGUAGES (en, ja, zh)
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.user_languages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    language_code VARCHAR(5) NOT NULL, -- 'en', 'ja', 'zh'
    current_level VARCHAR(30) DEFAULT 'Beginner', -- 'Beginner', 'Elementary', 'Intermediate'
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, language_code)
);

-- ------------------------------------------------------------------------------
-- 3. LEARNING GOALS
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.learning_goals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    language_code VARCHAR(5) NOT NULL,
    target_benchmark VARCHAR(50) NOT NULL, -- 'TOEIC 600', 'JLPT N3', 'HSK 3'
    target_date DATE,
    priority_level INT DEFAULT 1,
    current_progress_percent NUMERIC(5,2) DEFAULT 0.00,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, language_code)
);

-- ------------------------------------------------------------------------------
-- 4. LEARNING PATHS
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.learning_paths (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    language_code VARCHAR(5) NOT NULL,
    title TEXT NOT NULL,
    benchmark_code VARCHAR(30) NOT NULL, -- 'TOEIC_600', 'JLPT_N3', 'HSK_3'
    description TEXT,
    total_phases INT DEFAULT 5,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 5. LEARNING MODULES
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.learning_modules (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    path_id UUID NOT NULL REFERENCES public.learning_paths(id) ON DELETE CASCADE,
    phase_order INT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    skill_focus VARCHAR(20) NOT NULL, -- 'all', 'listening', 'speaking', 'reading', 'writing', 'grammar'
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 6. LESSONS
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.lessons (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    module_id UUID NOT NULL REFERENCES public.learning_modules(id) ON DELETE CASCADE,
    lesson_order INT NOT NULL,
    title TEXT NOT NULL,
    estimated_minutes INT DEFAULT 15,
    content_json JSONB NOT NULL DEFAULT '{}'::jsonb,
    is_published BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 7. VOCABULARY MASTER
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.vocabulary (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    language_code VARCHAR(5) NOT NULL,
    word TEXT NOT NULL,
    meaning_vi TEXT NOT NULL,
    part_of_speech VARCHAR(30),
    level VARCHAR(20) NOT NULL, -- 'A1', 'A2', 'B1', 'N5', 'N4', 'N3', 'HSK1', 'HSK2', 'HSK3'
    phonetic_ipa TEXT, -- For English
    kanji TEXT,        -- For Japanese
    furigana TEXT,     -- For Japanese
    romaji TEXT,       -- For Japanese
    simplified_chinese TEXT, -- For Chinese
    pinyin TEXT,       -- For Chinese
    tone_marks INT,    -- 1, 2, 3, 4, 5
    example_sentence TEXT,
    example_translation TEXT,
    audio_url TEXT,
    topic VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(language_code, word)
);

-- ------------------------------------------------------------------------------
-- 8. USER VOCABULARY (FSRS Spaced Repetition)
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.user_vocabulary (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    vocab_id UUID NOT NULL REFERENCES public.vocabulary(id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'new', -- 'new', 'learning', 'review', 'known'
    stability NUMERIC(10,4) DEFAULT 0.0,
    difficulty NUMERIC(10,4) DEFAULT 0.0,
    reps INT DEFAULT 0,
    lapses INT DEFAULT 0,
    state INT DEFAULT 0, -- 0=New, 1=Learning, 2=Review, 3=Relearning
    last_review TIMESTAMPTZ,
    next_review TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, vocab_id)
);

-- ------------------------------------------------------------------------------
-- 9. GRAMMAR MASTER
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.grammar (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    language_code VARCHAR(5) NOT NULL,
    level VARCHAR(20) NOT NULL,
    rule_name TEXT NOT NULL,
    explanation_vi TEXT NOT NULL,
    structure_formula TEXT NOT NULL,
    example_sentence TEXT NOT NULL,
    example_translation TEXT NOT NULL,
    common_mistakes_vi TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 10. EXERCISES
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.exercises (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lesson_id UUID REFERENCES public.lessons(id) ON DELETE SET NULL,
    exercise_type VARCHAR(30) NOT NULL, -- 'multiple_choice', 'dictation', 'shadowing', 'fill_blank'
    skill VARCHAR(20) NOT NULL, -- 'listening', 'speaking', 'reading', 'writing'
    prompt_question TEXT NOT NULL,
    media_url TEXT,
    options_json JSONB,
    correct_answer TEXT NOT NULL,
    explanation_vi TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 11. EXERCISE RESULTS
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.exercise_results (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    exercise_id UUID NOT NULL REFERENCES public.exercises(id) ON DELETE CASCADE,
    user_answer TEXT,
    is_correct BOOLEAN NOT NULL,
    accuracy_score NUMERIC(5,2),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 12. CONVERSATIONS
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    language_code VARCHAR(5) NOT NULL,
    scenario_title TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 13. CONVERSATION MESSAGES
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.conversation_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL REFERENCES public.conversations(id) ON DELETE CASCADE,
    sender_role VARCHAR(10) NOT NULL, -- 'user', 'ai'
    message_text TEXT NOT NULL,
    audio_url TEXT,
    error_category VARCHAR(30), -- 'grammar', 'vocabulary', 'pronunciation', 'word_order', 'expression', 'listening'
    correction_text TEXT,
    explanation_vi TEXT,
    natural_alternative TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 14. LISTENING MATERIALS
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.listening_materials (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    language_code VARCHAR(5) NOT NULL,
    level VARCHAR(20) NOT NULL,
    title TEXT NOT NULL,
    topic VARCHAR(50),
    audio_url TEXT NOT NULL,
    duration_seconds INT NOT NULL,
    transcript_json JSONB NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 15. READING MATERIALS
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.reading_materials (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    language_code VARCHAR(5) NOT NULL,
    level VARCHAR(20) NOT NULL,
    title TEXT NOT NULL,
    content_raw TEXT NOT NULL,
    content_annotated_json JSONB NOT NULL,
    translation_vi TEXT NOT NULL,
    questions_json JSONB NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 16. WRITING SUBMISSIONS
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.writing_submissions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    language_code VARCHAR(5) NOT NULL,
    topic_prompt TEXT NOT NULL,
    original_text TEXT NOT NULL,
    corrected_text TEXT,
    ai_feedback_vi TEXT,
    score NUMERIC(5,2),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 17. SPEAKING RECORDS
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.speaking_records (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    language_code VARCHAR(5) NOT NULL,
    scenario_or_prompt TEXT NOT NULL,
    user_audio_url TEXT,
    transcribed_text TEXT,
    fluency_score NUMERIC(5,2),
    grammar_score NUMERIC(5,2),
    vocabulary_score NUMERIC(5,2),
    pronunciation_score NUMERIC(5,2),
    comprehension_score NUMERIC(5,2),
    response_score NUMERIC(5,2),
    feedback_vi TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 18. REVIEW SCHEDULE
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.review_schedule (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    language_code VARCHAR(5) NOT NULL,
    item_type VARCHAR(20) NOT NULL, -- 'vocabulary', 'grammar', 'mistake_pattern'
    item_id UUID NOT NULL,
    scheduled_for DATE NOT NULL,
    is_completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 19. LEARNING PROGRESS
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.learning_progress (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    language_code VARCHAR(5) NOT NULL,
    date DATE NOT NULL,
    study_duration_seconds INT DEFAULT 0,
    words_learned INT DEFAULT 0,
    words_reviewed INT DEFAULT 0,
    listening_minutes INT DEFAULT 0,
    speaking_minutes INT DEFAULT 0,
    estimated_benchmark_score INT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, language_code, date)
);

-- ------------------------------------------------------------------------------
-- 20. ERROR PATTERNS
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.error_patterns (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    language_code VARCHAR(5) NOT NULL,
    category VARCHAR(30) NOT NULL,
    pattern_description TEXT NOT NULL,
    frequency_count INT DEFAULT 1,
    remedy_lesson_id UUID REFERENCES public.lessons(id),
    last_occurred TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 21. DAILY LEARNING PLAN
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.daily_learning_plan (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    plan_date DATE NOT NULL,
    plan_json JSONB NOT NULL,
    is_completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, plan_date)
);

-- ------------------------------------------------------------------------------
-- 22. USER MATERIALS (OCR / PDF / Text)
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.user_materials (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    language_code VARCHAR(5) NOT NULL,
    file_type VARCHAR(10) NOT NULL, -- 'pdf', 'image', 'text'
    source_url TEXT,
    extracted_text TEXT NOT NULL,
    ai_generated_lesson_json JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- 23. STUDY SESSIONS
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.study_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    language_code VARCHAR(5) NOT NULL,
    session_mode VARCHAR(20) NOT NULL, -- 'normal', 'driving_mode', 'quick_review'
    duration_seconds INT NOT NULL,
    started_at TIMESTAMPTZ NOT NULL,
    ended_at TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ------------------------------------------------------------------------------
-- INDEXES FOR PERFORMANCE
-- ------------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_vocab_lang ON public.vocabulary(language_code);
CREATE INDEX IF NOT EXISTS idx_user_vocab_review ON public.user_vocabulary(user_id, next_review);
CREATE INDEX IF NOT EXISTS idx_conv_messages_conv ON public.conversation_messages(conversation_id);
CREATE INDEX IF NOT EXISTS idx_progress_user_date ON public.learning_progress(user_id, date);
CREATE INDEX IF NOT EXISTS idx_review_schedule ON public.review_schedule(user_id, scheduled_for, is_completed);

-- ------------------------------------------------------------------------------
-- SEED DATA: LEARNING PATHS (TOEIC 600, JLPT N3, HSK 3)
-- ------------------------------------------------------------------------------
INSERT INTO public.learning_paths (id, language_code, title, benchmark_code, description, total_phases)
VALUES 
('a0000001-0000-0000-0000-000000000001', 'en', 'Lộ trình Tiếng Anh TOEIC 600', 'TOEIC_600', 'Xây dựng nền tảng từ vựng, ngữ pháp, phản xạ nghe nói và chinh phục kỳ thi TOEIC 600.', 6),
('a0000002-0000-0000-0000-000000000002', 'ja', 'Lộ trình Tiếng Nhật JLPT N3', 'JLPT_N3', 'Từ bảng chữ cái Hiragana/Katakana, Kanji căn bản đến trung cấp JLPT N3.', 5),
('a0000003-0000-0000-0000-000000000003', 'zh', 'Lộ trình Tiếng Trung HSK 3', 'HSK_3', 'Làm chủ ngữ âm Pinyin, chữ Hán cơ bản và giao tiếp lưu loát đến cấp độ HSK 3.', 5)
ON CONFLICT DO NOTHING;
