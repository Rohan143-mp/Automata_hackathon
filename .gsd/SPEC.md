# SYNAPSE: The Bio-Digital Larynx (SPEC)

## 1. Vision
**SYNAPSE** is an inclusive learning platform and full-duplex communication suit designed for specially-abled students. It acts as a physical extension of the body, translating raw muscle signals (gestures) and intent into fluent, context-aware speech, while also incorporating speech-to-text (STT) capabilities. 

By integrating hardware (smart gloves, bone conduction) and software (LLMs, TTS, STT) with real-time biometric feedback (heart rate), Synapse transforms passive tech into active, emotional, and instant participation in the classroom.

This project evolves an existing Flutter-based health application (formerly HealthGuard) by repurposing its robust vitals-tracking foundation to drive affective (emotion-aware) communication.

## 2. Core Components

### 2.1 Hardware (The Suit)
*   **"Muscle" Controller:** Arduino Uno R3 (5V logic, reads analog flex sensors and I2C gyro).
*   **WiFi Gateway:** ESP8266 NodeMCU (3.3V logic, transmits sensor telemetry via WebSockets).
*   **Input Array (Hand to Voice):**
    *   5x Flex Sensors (for detecting finger bending).
    *   1x MPU6050 6-Axis Accelerometer/Gyro (for detecting hand orientation/tilt).
    *   1x Pulse Sensor (for detecting heart rate, simulating emotion/excitement).
*   **Output Array (Voice to Bone):**
    *   1x Bone Conduction Transducer (student "hears" their digital voice and the teacher inside their skull).
    *   1x PAM8403 Amplifier.
*   **Data Bridge:** Serial communication between Arduino and ESP8266.

### 2.2 Software (The Brain)
*   **Mobile App (Flutter):**
    *   Acts as the central hub, receiving WebSocket telemetry from the ESP8266.
    *   Reuses existing HealthGuard vitals infrastructure to monitor baseline health and augment the pulse sensor data.
    *   **Innovation A: Neural-Intent Engine:** Maps 7-D vectors (5 fingers + 2 tilt angles) to a local gesture library (Cosine Similarity match). Feeds the matched intent + classroom context into an LLM (existing Gemini integration) to generate polite, fluent sentences.
    *   **Innovation B: Affective Resonance (TTS):** Uses Flutter TTS to articulate the generated sentence. Modulates pitch and rate based on real-time heart rate (e.g., higher HR = faster, higher pitch).
    *   **Whisper STT Integration:** Uses OpenAI's Whisper API to transcribe the teacher's/environment's speech into text. This text is then routed to the bone conduction output so the student can "hear" or read the lesson.
*   **Backend (Node.js/Express):**
    *   Existing backend (SQLite) handles user profiles, historical vitals storage, and session management.
    *   Acts as a WebSocket relay if direct ESP8266-to-Flutter communication isn't viable on the local network.

## 3. High-Level Architecture Flow

1.  **Gesture Input:** Student signs. Arduino reads flex/gyro sensors.
2.  **Telemetry:** Arduino serializes data string `<F1,F2,F3,F4,F5,GX,GY,HR>` -> ESP8266 -> WebSocket -> Flutter App.
3.  **Vector Matching:** Flutter App compares incoming 7D vector against `GestureLibrary.json` using Cosine Similarity.
4.  **Context Generation:** Matched intent (e.g., "Need help") + Whisper STT context (e.g., Teacher is talking about math) -> Gemini LLM -> Output: "Excuse me Professor, I need help with this equation."
5.  **Affective Audio Output:** Flutter App checks HR. Applies pitch/speed modifiers -> Flutter TTS -> PAM8403 Amp -> Bone Conduction Headset.
6.  **Environmental Input:** OpenAI Whisper listens to the classroom, converts to text, displays on the Flutter App, and pushes to bone conduction for the student.

## 4. Immediate Development Phases

To integrate the hackathon hardware pitch with the existing Flutter/Node.js codebase, the following phases are required:

1.  **Phase 1: Whisper Integration (STT)**
    *   Implement audio recording in Flutter.
    *   Integrate OpenAI Whisper API for speech-to-text.
    *   Build the "Classroom Listening" UI.
2.  **Phase 2: Hardware Telemetry Service (IoT)**
    *   Create a WebSocket server/client in Flutter or backend to receive Arduino/ESP8266 data packets.
    *   Build a visual debug screen for incoming telemetry (Flex, Gyro, Pulse).
3.  **Phase 3: The Neural-Intent Engine**
    *   Implement 7D Vector mapping and Cosine Similarity matching in Dart.
    *   Create `GestureLibrary.json`.
    *   Modify existing `ChatService` (Gemini) to accept gesture intents and output contextual speech.
4.  **Phase 4: Affective Resonance (TTS)**
    *   Modify existing TTS implementation (or add one) to dynamically modulate `pitch` and `rate` based on the live HR variable received from the hardware.

## 5. Non-Goals / Out of Scope (For Now)
*   Training a custom on-device ML model for gesture recognition (starting with heuristic Cosine Similarity).
*   Full VR/AR integration.
*   Manufacturing the physical glove (software focus here).

## 6. Open Questions
*   How will the ESP8266 communicate with the Flutter app? (Direct WebSocket over local WiFi, or via the Node.js backend as a relay?)
*   Does the user have an OpenAI API key ready for Whisper?
