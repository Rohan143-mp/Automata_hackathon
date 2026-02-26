---
phase: 1
plan: 2
wave: 2
depends_on: [1]
---

# Plan 1.2: Flutter App Audio Recording & Streaming

## Objective
Implement audio recording capabilities in the `healthguard_app` using the `record` package and a WebSocket client to stream the audio directly to the PC Hub.

**Deliverables:**
- Modified `pubspec.yaml` with recording dependencies.
- A new `AudioStreamService` in Flutter that records mic input and sends raw chunks to the WebSocket server created in Plan 1.1.
- UI components in the Classroom screen to toggle recording.

## Context
- `.gsd/SPEC.md`
- `healthguard_app/pubspec.yaml`
- `healthguard_app/lib/features/classroom/classroom_screen.dart` (needs creating if missing)
- `healthguard_app/lib/main.dart`

## Tasks

<task type="auto">
  <name>Add Dependencies</name>
  <files>healthguard_app/pubspec.yaml, healthguard_app/android/app/src/main/AndroidManifest.xml</files>
  <action>
    Add to `pubspec.yaml`:
    - `record: ^5.1.2`
    - `web_socket_channel: ^3.0.1`

    Add `RECORD_AUDIO` and `INTERNET` permissions to the Android Manifest.
  </action>
  <verify>cd healthguard_app && flutter pub get</verify>
  <done>Dependencies resolve and pubspec.yaml updated</done>
</task>

<task type="auto">
  <name>Implement Audio Stream Service</name>
  <files>healthguard_app/lib/services/audio_stream_service.dart</files>
  <action>
    Create the `AudioStreamService`:
    - Define `connect(String wsUrl)` using `WebSocketChannel`.
    - Define `startStreaming()` to begin recording via the `record` package (using a Stream if possible, or short file chunks) and pipe the bytes into the `WebSocketChannel`.
    - Define `stopStreaming()` to close recorder and channel.
    - Set audio format to PCM 16kHz Mono as expected by whisper.
  </action>
  <verify>dart analyze healthguard_app/lib/services/audio_stream_service.dart</verify>
  <done>AudioStreamService compiles with zero analysis errors</done>
</task>

<task type="auto">
  <name>Classroom UI Integration</name>
  <files>healthguard_app/lib/features/classroom/classroom_screen.dart, healthguard_app/lib/main.dart</files>
  <action>
    Create or update `ClassroomScreen` to have a large Microphone button.
    When tapped, it turns red and calls `AudioStreamService.startStreaming(HUB_IP)`.
    When tapped again, it stops.
    Add UI elements to show the transcribed text that (eventually) comes back from the WebSocket (set up the listener in `AudioStreamService` and expose via a Stream/Provider).
    Ensure the `ClassroomScreen` is accessible from the main Dashboard.
  </action>
  <verify>dart analyze healthguard_app/lib/features/classroom/classroom_screen.dart healthguard_app/lib/main.dart</verify>
  <done>UI integrates AudioStreamService and compiles</done>
</task>

## Success Criteria
- [ ] Record and WebSocket packages added to Flutter project.
- [ ] `AudioStreamService` compiles.
- [ ] Classroom screen has Start/Stop recording toggle.
