---
phase: 1
plan: 2
wave: 2
depends_on: [01-whisper-service]
files_modified:
  - healthguard_app/lib/features/classroom/classroom_screen.dart
  - healthguard_app/lib/main.dart
  - healthguard_app/lib/features/dashboard/dashboard_screen.dart
autonomous: true

must_haves:
  truths:
    - "User can navigate to the Classroom screen from the dashboard"
    - "User can tap a mic button to start/stop recording"
    - "Transcribed text appears on screen after each recording"
    - "Multiple transcriptions accumulate as a running log"
  artifacts:
    - "healthguard_app/lib/features/classroom/classroom_screen.dart"
---

# Plan 1.2: Classroom Screen UI

<objective>
Build the student-facing "Classroom" screen where they can activate live listening and see the teacher's words transcribed in real-time.

Purpose: This is the visible proof of Phase 1 — a screen the student uses every day in class.
Output: A polished, accessible Flutter screen with mic toggle and running transcript.
</objective>

<context>
Load for context:
- healthguard_app/lib/main.dart (routing patterns)
- healthguard_app/lib/features/dashboard/dashboard_screen.dart (navigation patterns)
- healthguard_app/lib/services/whisper_service.dart (created in Plan 1.1)
</context>

<tasks>

<task type="auto">
  <name>Create ClassroomScreen widget</name>
  <files>healthguard_app/lib/features/classroom/classroom_screen.dart</files>
  <action>
    Create a `StatefulWidget` named `ClassroomScreen`.

    UI Layout:
    1. **AppBar:** Title "Classroom" with a subtitle showing Whisper model status ("Ready" / "Loading model...").
    2. **Body:** A `ListView` that displays transcription entries. Each entry shows:
       - Timestamp
       - Transcribed text
       - A divider
    3. **FAB (Floating Action Button):** Large microphone icon.
       - Default state: Mic icon, accent color. Tap → calls `WhisperService.startRecording()`, changes to a red "stop" icon with a pulsing animation.
       - Recording state: Red stop icon. Tap → calls `WhisperService.stopAndTranscribe()`, shows a `CircularProgressIndicator` while inferring, then adds the result to the transcript list.

    State Management:
    - `List<Map<String, String>> _transcripts` — stores `{time, text}` pairs.
    - `bool _isRecording`
    - `bool _isTranscribing`
    - `bool _isModelReady`

    Lifecycle:
    - `initState()` → call `WhisperService().initialize()` and set `_isModelReady` when done.
    - `dispose()` → call `WhisperService().dispose()`.

    Accessibility:
    - Large text (18sp minimum) for readability.
    - High contrast colors.
    - Semantic labels on all buttons.

    AVOID: Complex state management (use `setState`). Do NOT use Provider, BLoC, or Riverpod.
  </action>
  <verify>cd healthguard_app; dart analyze lib/features/classroom/classroom_screen.dart</verify>
  <done>ClassroomScreen compiles with zero analysis errors. Has mic toggle, transcript list, loading states.</done>
</task>

<task type="auto">
  <name>Add route and dashboard navigation</name>
  <files>healthguard_app/lib/main.dart, healthguard_app/lib/features/dashboard/dashboard_screen.dart</files>
  <action>
    In `main.dart`:
    - Import `ClassroomScreen`.
    - Add route: `'/classroom': (context) => const ClassroomScreen()`.

    In `dashboard_screen.dart`:
    - Add a new card/button in the dashboard grid labeled "Classroom" with an appropriate icon (e.g., `Icons.hearing` or `Icons.record_voice_over`).
    - On tap: `Navigator.pushNamed(context, '/classroom')`.

    AVOID: Breaking existing dashboard layout or navigation flow.
  </action>
  <verify>cd healthguard_app; dart analyze lib/main.dart lib/features/classroom/classroom_screen.dart</verify>
  <done>Route exists. Dashboard has "Classroom" button. Navigation works.</done>
</task>

</tasks>

<verification>
After all tasks, verify:
- [ ] `dart analyze` passes on all modified files
- [ ] Route '/classroom' is defined in main.dart
- [ ] Dashboard shows "Classroom" entry point
- [ ] ClassroomScreen handles all states (loading, ready, recording, transcribing)
</verification>

<success_criteria>
- [ ] All tasks verified
- [ ] Must-haves confirmed
</success_criteria>
