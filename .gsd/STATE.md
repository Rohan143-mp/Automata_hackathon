# STATE.md — Project Memory

## Last Session Summary
On 2026-02-25, completed deep project rethink of SYNAPSE.
- Rewrote SPEC.md with full hackathon pitch, 3 innovations, tech stack, data flow
- Rewrote ROADMAP.md with 5 phases AND dependency graph
- Rewrote ARCHITECTURE.md with SYNAPSE system layers
- Created Phase 1 execution plans (Whisper Service + Classroom UI)
- Confirmed tech choices: whisper_ggml_plus (local), web_socket_channel, record

## Current Position
- **Phase**: 1 (The Ear — Local Whisper STT)
- **Task**: Plans ready, awaiting execution
- **Status**: Run `/execute 1` to begin

## Technology Decisions
| Decision | Choice | Why |
|----------|--------|-----|
| Local Whisper | whisper_ggml_plus ^1.3.3 | whisper.cpp bindings, Large-v3-Turbo support, 1.2K downloads |
| WebSocket | web_socket_channel ^3.0.3 | Official Dart team, 5.5M downloads |
| Audio Recording | record ^5.1.2 | Modern Flutter recording |
| Model | ggml-tiny.en.bin | 75MB, fast inference, English-only (sufficient for demo) |

## Next Steps
1. Execute Phase 1 (Whisper + Classroom UI)
2. Then Phase 2 (IoT Telemetry)
3. Phases 1 & 2 can run in parallel
