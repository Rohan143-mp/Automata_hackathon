# ROADMAP: SYNAPSE (The Bio-Digital Larynx)

## High-Level Execution Plan

This roadmap outlines the steps to evolve the existing HealthGuard Flutter app into the SYNAPSE inclusive learning platform, integrating the hardware pitch (smart glove + pulse sensor) with software AI (Whisper STT + Gemini TTS modulation).

### Phase 1: Whisper Integration (The Ear)
**Goal:** Implement real-time speech-to-text so the student can "hear" the teacher's lessons transcribed on screen, ready for bone-conduction routing.
- [ ] Add `record` and `path_provider` dependencies for audio capture.
- [ ] Create `WhisperService` to handle audio recording and API calls to OpenAI Whisper.
- [ ] Build a "Classroom/Listening" UI screen to display real-time transcriptions.
- [ ] Add OpenAI API key configuration to `ai_config.dart`.

### Phase 2: IoT Telemetry Service (The Nervous System)
**Goal:** Establish a real-time connection between the hardware ESP8266 and the Flutter app to receive sensor data.
- [ ] Implement a WebSocket server/client in Flutter (`web_socket_channel`).
- [ ] Define a `HardwareTelemetry` data model to parse the incoming CSV string (`<Flex1,Flex2,Flex3,Flex4,Flex5,GyroX,GyroY,HeartRate>`).
- [ ] Create a debug UI screen to visualize live sensor data (flex bending, gyro tilt, HR).

### Phase 3: The Neural-Intent Engine (The Brain)
**Goal:** Translate raw 7D vectors (hand gestures) into context-aware speech using local matching and Gemini.
- [ ] Create `GestureLibrary.json` with base reference vectors for common signs (e.g., "Hello", "Question", "Yes", "No").
- [ ] Implement Cosine Similarity math function in Dart to match live telemetry against the library.
- [ ] Update `ChatService` (or create `IntentService`) to take the matched gesture intent + current Whisper classroom context -> send to Gemini -> receive fluent sentence.

### Phase 4: Affective Resonance TTS (The Voice)
**Goal:** Speak the generated sentence using Flutter TTS, modulating the voice based on the live heart rate.
- [ ] Integrate existing `flutter_tts` package.
- [ ] Create `VoiceService` to handle TTS output.
- [ ] Implement logic: Map live Heart Rate (from telemetry) to TTS `pitch` and `rate` modifiers.
    *   *High HR (>90) = Fast rate, higher pitch (Excited/Anxious).*
    *   *Low HR (<65) = Slow rate, lower pitch (Calm).*
- [ ] Wire the audio output to default to the headphone jack (for the PAM8403 Amp -> Bone Conduction).

### Phase 5: Hardware Integration & Polish (The Body)
**Goal:** Final end-to-end testing with the physical Arduino/ESP8266 glove.
- [ ] Refine the UI/UX for the "Wow" Demo Sequence.
- [ ] Tune Cosine Similarity thresholds for gesture recognition accuracy.
- [ ] Ensure robust error handling for API timeouts or WebSocket disconnects.
- [ ] Finalize documentation and presentation materials.
