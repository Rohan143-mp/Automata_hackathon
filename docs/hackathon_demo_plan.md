# SYNAPSE — Hackathon Demo Strategy & Execution Plan

> **Problem Statement:** ET-4: Inclusive Learning Platform for Specially-Abled Students
> **Tagline:** From Raw Muscle Signals to Fluent, Resonant Conversation

---

## Current Readiness Audit

### ✅ Hardware (Working)
| Component | Status | Notes |
|-----------|--------|-------|
| Arduino Uno + 4 Flex Sensors | ✅ Tested | Index/Middle/Ring/Pinky on A0-A3 |
| MPU6050 Gyroscope | ✅ Tested | Soldered, on A4/A5 |
| ESP8266 NodeMCU | 🔧 Have it | Not yet wired to Uno |
| 5th Flex (Thumb) | 🔧 Have it | Goes on ESP8266 A0 |
| Serial Bridge (1kΩ/2kΩ divider) | ❌ Not wired | Next step |
| PAM8403 + Bone Transducer | ❌ Not wired | Optional for demo |

### ✅ Software (Built)
| Component | Status | File |
|-----------|--------|------|
| Gesture Engine (cosine similarity) | ✅ | `hub/services/gesture_engine.py` |
| 9 Gestures in Library | ✅ | `hub/utils/gesture_library.json` |
| Ollama LLM Intent Expansion | ✅ | `hub/services/intent_service.py` |
| pyttsx3 TTS Voice Output | ✅ | `hub/services/voice_service.py` |
| WebSocket Hub Server | ✅ | `hub/main_server.py` |
| Flutter Dashboard (Telemetry) | ✅ | `healthguard_app/lib/features/dashboard/` |
| Flutter Classroom (Whisper) | ✅ | `healthguard_app/lib/features/classroom/` |
| Glove Simulator (Dev Tool) | ✅ | `scripts/simulate_glove.py` |
| Whisper Transcription | ✅ | `pc_hub/whisper_service.py` |
| Docker Compose | ✅ | `docker-compose.yml` |

---

## What Demos Are Possible

### Demo 1: 🤟 "The Sign" — Live Gesture Recognition
**What:** Wear the glove, make a sign → PC instantly identifies it on screen.
**Shows:** IoT → WiFi → Server pipeline working in real-time.
**Wow factor:** ⭐⭐⭐ — Tangible hardware, live sensor data.

### Demo 2: 🧠 "The Brain" — AI-Powered Intent Expansion
**What:** Sign "question" → LLM expands to "Excuse me, I have a question about what you just explained."
**Shows:** Raw shorthand → contextual, fluent English via local AI.
**Wow factor:** ⭐⭐⭐⭐⭐ — This is the "holy shit" moment.

### Demo 3: 🗣️ "The Voice" — Text-to-Speech Output
**What:** The expanded sentence is spoken aloud from the PC.
**Shows:** The deaf-mute student now has a "Digital Larynx" — a synthetic voice.
**Wow factor:** ⭐⭐⭐⭐ — Emotional impact, the room hears the student "speak."

### Demo 4: 👂 "The Ear" — Classroom Audio Transcription
**What:** Teacher speaks → phone mic captures → Whisper transcribes → provides context to the AI.
**Shows:** Full-duplex communication — student can both "speak" and "hear."
**Wow factor:** ⭐⭐⭐⭐ — Closes the loop on two-way communication.

### Demo 5: 📱 "The Dashboard" — Flutter App Telemetry
**What:** Flutter app on phone shows SIGN DETECTED + AI TRANSLATION in real-time.
**Shows:** Clean, branded SYNAPSE UI with live data streaming.
**Wow factor:** ⭐⭐⭐ — Polished presentation, shows full-stack capability.

### Demo 6 (Bonus): 🎮 "The Simulator" — No-Hardware Fallback
**What:** If hardware fails, use `simulate_glove.py` to type gestures and still demo the full AI pipeline.
**Shows:** Same brain pipeline works, just without physical glove.
**Why:** **This is your safety net.** Hardware can fail at demos — this ensures you always have a working demo.

---

## The 5-Act Demo Script (5 minutes)

> [!IMPORTANT]
> This script is designed to build emotional momentum. Each act adds a layer. Practice this sequence.

### Act 1: "The Silence" (30 sec)
*Stand silently. Let the audience feel the frustration of not being able to speak.*
> "Imagine sitting in a classroom every day, understanding everything, but having no voice to participate."

### Act 2: "The Connection" (60 sec)
*Put on the glove. Show it connecting to WiFi. Show the Flutter app receiving data.*
> "This is SYNAPSE — a glove with 5 flex sensors and a gyroscope. It reads the student's hand position 50 times per second and streams it to our AI hub."

**Live action:** Wiggle fingers → show raw sensor values changing on dashboard.

### Act 3: "The Intelligence" (90 sec)
*This is the money shot. Make deliberate signs.*
> "Watch this. The student signs 'question'..."

**Live action:**
1. Sign **"question"** → Dashboard shows `[QUESTION]` → LLM expands → "Excuse me, I have a question"
2. Sign **"help"** → `[HELP]` → "I need some help understanding this concept"
3. Sign **"i am miran"** → `[I AM MIRAN]` → "My name is Miran"

> "Nine different gestures, each expanded into natural fluent English by a local LLM — no cloud, no internet needed."

### Act 4: "The Voice" (60 sec)
*Turn up the speakers. Let the room hear the TTS output.*
> "But text isn't enough. SYNAPSE gives the student an actual voice."

**Live action:** Sign → TTS speaks the expanded sentence aloud.

> "This is the Bio-Digital Larynx — the student's words, spoken for the first time."

### Act 5: "The Full Loop" (60 sec)
*Open the classroom screen on the phone. Have a teammate speak into the mic.*
> "Communication is two-way. SYNAPSE also listens."

**Live action:** Teammate says something → Whisper transcribes → appears as context → Student signs a response → AI uses that context to generate a relevant reply.

> "For the first time, this student can fully participate in a classroom conversation."

---

## Execution Priority (What to Do Next)

### 🔴 CRITICAL (Must-Do Before Demo)

| # | Task | Time Est. | Notes |
|---|------|-----------|-------|
| 1 | Wire Uno → ESP8266 serial bridge | 30 min | 1kΩ/2kΩ voltage divider |
| 2 | Wire Thumb flex to ESP8266 A0 | 10 min | With 10kΩ pull-down, use 3.3V |
| 3 | Flash `synapse_sensor.ino` to Uno | 5 min | Already written |
| 4 | Flash `synapse_wifi.ino` to ESP8266 | 5 min | Already written |
| 5 | Update WiFi credentials in ESP firmware | 2 min | Use your actual WiFi SSID/password |
| 6 | Update `GLOVE_WS_URL` in `main_server.py` | 2 min | Set to ESP8266's IP address |
| 7 | Test full pipeline: Glove → Hub → TTS | 30 min | End-to-end validation |
| 8 | Calibrate gesture library with REAL sensor values | 45 min | Recording actual flex values from YOUR sensors |

### 🟡 IMPORTANT (Big Impact on Demo Quality)

| # | Task | Time Est. | Notes |
|---|------|-----------|-------|
| 9 | Install & test Ollama with a small model | 20 min | Use `phi3` or `llama3` — fast inference |
| 10 | Test Whisper transcription end-to-end | 15 min | Phone mic → PC → transcript visible |
| 11 | Run Flutter app on a real phone (not emulator) | 15 min | Much more impressive for judges |
| 12 | Practice the 5-act demo script 3 times | 30 min | Timing and smooth transitions |

### 🟢 NICE-TO-HAVE (Polish)

| # | Task | Time Est. | Notes |
|---|------|-----------|-------|
| 13 | Wire PAM8403 + bone transducer | 20 min | Physical "voice" output |
| 14 | Add more gestures to library | 30 min | More demo variety |
| 15 | dockerize the setup for reliability | 20 min | Already have docker-compose.yml |

---

## 🛡️ Risk Mitigation

| Risk | Mitigation |
|------|-----------|
| **WiFi drops during demo** | Have laptop hotspot as backup. Pre-connect before going on stage. |
| **Glove hardware fails** | **Always have `simulate_glove.py` ready** as a backup. Same demo, just typed. |
| **Ollama is too slow** | Use `phi3` (tiny model) instead of `llama3`. Or pre-cache common responses. |
| **Flex sensors give bad readings** | Calibrate `gesture_library.json` with YOUR actual sensor values, not default ones. |
| **ESP8266 won't connect** | Print the IP in Serial Monitor. Use a fixed IP reservation on your router. |

---

## ⚠️ Critical Calibration Step

> [!CAUTION]
> The current `gesture_library.json` uses **placeholder values** (300/800). Your actual flex sensors will have DIFFERENT ranges. You MUST record real values from your sensors and update the library before the demo.

**How to calibrate:**
1. Upload the full Uno test sketch
2. Make each gesture (open, fist, point, etc.) while watching Serial Monitor
3. Note down the actual values for each finger position
4. Update `hub/utils/gesture_library.json` with the real numbers

---

## Time Budget

| Phase | Tasks | Estimated Time |
|-------|-------|---------------|
| Hardware wiring (ESP bridge + thumb) | #1–#2 | 40 min |
| Firmware upload & WiFi setup | #3–#6 | 15 min |
| End-to-end test & calibration | #7–#8 | 1.5 hours |
| Software validation (Ollama + Whisper) | #9–#10 | 35 min |
| Demo rehearsal | #12 | 30 min |
| **Total** | | **~3.5 hours** |
