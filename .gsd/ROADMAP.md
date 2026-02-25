# ROADMAP: SYNAPSE

> Execution plan to evolve HealthGuard → SYNAPSE
> Each phase delivers a **vertical slice** that can be demonstrated independently.

---

## Phase 1: The Ear (Local Whisper STT)
**Milestone:** Student can hear the classroom transcribed on-screen, fully offline.

| # | Task | Files | Wave |
|---|------|-------|------|
| 1.1 | Add `whisper_ggml_plus`, `record`, `path_provider` deps | `pubspec.yaml` | 1 |
| 1.2 | Download `ggml-tiny.en.bin` model to app assets | `assets/models/` | 1 |
| 1.3 | Create `WhisperService` (init model, record, transcribe) | `services/whisper_service.dart` | 1 |
| 1.4 | Build `ClassroomScreen` UI (mic button, live transcript) | `features/classroom/` | 2 |
| 1.5 | Add route + navigation entry from dashboard | `main.dart`, `dashboard_screen.dart` | 2 |

**Demo:** Tap mic → speak into phone → text appears on screen. No internet.

---

## Phase 2: The Nervous System (IoT Telemetry)
**Milestone:** Live sensor data streams from glove → phone over WiFi.

| # | Task | Files | Wave |
|---|------|-------|------|
| 2.1 | Add `web_socket_channel` dependency | `pubspec.yaml` | 1 |
| 2.2 | Create `TelemetryService` (WebSocket client, CSV parser) | `services/telemetry_service.dart` | 1 |
| 2.3 | Create `HardwareTelemetry` model (flex×5, gyro×2, HR) | `models/hardware_telemetry.dart` | 1 |
| 2.4 | Build `GloveDebugScreen` (live sensor visualization) | `features/glove/glove_debug_screen.dart` | 2 |
| 2.5 | Add route + navigation entry | `main.dart` | 2 |

**Demo:** Bend fingers on glove → bars move on phone screen in real-time.

---

## Phase 3: The Brain (Neural-Intent Engine)
**Milestone:** Student signs a gesture → system speaks a fluent, context-aware sentence.

| # | Task | Files | Wave |
|---|------|-------|------|
| 3.1 | Create `GestureLibrary.json` (reference vectors for 10+ gestures) | `assets/gesture_library.json` | 1 |
| 3.2 | Implement `GestureEngine` (cosine similarity matching in Dart) | `services/gesture_engine.dart` | 1 |
| 3.3 | Create `IntentService` (gesture intent + Whisper context → Gemini → sentence) | `services/intent_service.dart` | 2 |
| 3.4 | Build `GloveScreen` (shows matched gesture, generated sentence, speak button) | `features/glove/glove_screen.dart` | 2 |

**Demo:** Sign "Hello" → screen shows "Hello everyone, nice to meet you." → phone speaks it.

---

## Phase 4: The Voice (Affective Resonance TTS)
**Milestone:** Generated speech has emotion — pitch and speed change with heart rate.

| # | Task | Files | Wave |
|---|------|-------|------|
| 4.1 | Create `VoiceService` (wraps `flutter_tts`, accepts HR parameter) | `services/voice_service.dart` | 1 |
| 4.2 | Implement HR→pitch/rate mapping table | `services/voice_service.dart` | 1 |
| 4.3 | Wire end-to-end: TelemetryService HR → VoiceService → TTS output | `features/glove/glove_screen.dart` | 2 |

**Demo:** Jog in place (HR rises) → sign "Win" → voice says "We're going to WIN!" in an excited tone.

---

## Phase 5: The Body (Integration & Polish)
**Milestone:** End-to-end demo-ready. All systems working together.

| # | Task | Files | Wave |
|---|------|-------|------|
| 5.1 | Rebrand app from HealthGuard → SYNAPSE (app name, theme, splash) | Multiple UI files | 1 |
| 5.2 | Create unified "Synapse Mode" screen (gesture + transcript + voice in one view) | `features/synapse/synapse_screen.dart` | 1 |
| 5.3 | Tune cosine similarity thresholds with real glove data | `assets/gesture_library.json` | 2 |
| 5.4 | Add error recovery (WebSocket reconnect, model reload) | Services layer | 2 |
| 5.5 | Demo rehearsal and timing optimization | — | 3 |

**Demo:** The full "Wow" sequence from the pitch document.

---

## Dependency Graph

```
Phase 1 (Ear)  ──┐
                  ├──▶ Phase 3 (Brain) ──▶ Phase 4 (Voice) ──▶ Phase 5 (Body)
Phase 2 (Nerves) ┘
```

Phases 1 and 2 are **independent** and can be built in parallel.
Phase 3 requires both (gesture vectors from Phase 2 + classroom context from Phase 1).
Phase 4 requires Phase 3 (needs sentences to speak).
Phase 5 integrates everything.
