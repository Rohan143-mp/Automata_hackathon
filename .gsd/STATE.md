# STATE.md — Project Memory

## Last Session Summary
On 2026-02-25, completely pivoted project to actualize **SYNAPSE (The Bio-Digital Larynx)** targeting Hackathon PS ET-4.
- Integrated complete IoT Hardware BOM (Arduino, ESP8266, MPU6050, Flex Sensors, Pulse Sensor, Bone Conduction).
- Replaced Phone-Vitals dependency with physical Pulse Sensor on the Smart Glove.
- Upgraded Gesture Matching to 7D Vector-Space Recognition via Cosine Similarity.
- Added Affective Resonance (Heart Rate modulates TTS Pitch/Speed).
- Re-architected data flow to rely on ESP8266 WebSocket streaming instead of USB serial.

## Current Position
- **Phase**: 1 & 2 (The Ear & The IoT Glove)
- **Task**: Plans completely overhauled and finalized for Hardware+Software integration
- **Status**: Ready to procure BOM or build mock software layers.

## Technology Decisions
| Decision | Choice | Why |
|----------|--------|-----|
| Central Brain | PC Hub (Python) | Processes Whisper, Cosine Similarity, and Ollama in one beefy local machine |
| App Role | Audio Source & Telemetry | App captures mic audio and sends to PC, while listening to WebSocket to display the final state |
| Audio Recording | `record` package (Flutter) | Modern, robust Flutter audio capturing library for capturing classroom context |
| Local Whisper | faster-whisper (Python) | running on the PC Hub, parses the audio chunks sent by the Flutter App |
| Microcontrollers | Arduino Uno + ESP8266 | Split-brain architecture: 5V analog muscles (Uno) + 3.3V WiFi brain (ESP) |
| Hub Sync | Python WebSocket Server | Receives Audio/Vectors, and streams Transcripts and LLM output back to the App |
| Output Audio | PAM8403 + Bone Conduction | Phantom voice feedback creates neurological loop of speaking |
| AI Intent | Local Ollama (Python layer) | Translates shorthand phrases locally, ensuring ultra-low latency, privacy, and full offline capability without API keys |

## Key Improvements (from deep analysis)
- Hardware replaces finicky smartwatch integration (Pulse Sensor directly on I2C/Analog).
- Smart Glove is truly wireless using ESP8266 WiFi Gateway.
- Vector matching is resilient to shaky hands unlike raw if/else thresholds.

## Next Steps
1. Procure missing hardware (Pulse Sensor, Bone Conduction, Capacitors).
2. Execute Phase 1 (Whisper context pipeline) locally.
3. Build Phase 2 Mock Data generator until hardware is assembled.
