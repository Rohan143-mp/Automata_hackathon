---
phase: 1
plan: 1
wave: 1
---

# Plan 1.1: PC Hub Faster-Whisper Context Pipeline

## Objective
Create a Python script on the PC Hub that receives audio chunks via WebSocket, transcribes them using `faster-whisper`, and logs the text to provide context for the Neural-Intent engine.

**Deliverables:**
- Basic project structure for the PC Hub
- Real-time or near real-time English audio transcription loop using `faster-whisper`
- A WebSocket Server ready to accept bytes from the Flutter App

## Context
- `.gsd/SPEC.md` (Section 3: System Architecture, Section 4A & 5: Tech Stack)
- `.gsd/ROADMAP.md` (Phase 1)

## Tasks

<task type="auto">
  <name>Setup PC Hub Environment and Dependencies</name>
  <files>pc_hub/requirements.txt</files>
  <action>
    Create a new directory `pc_hub` in the root of the repository.
    Create a `requirements.txt` file and add:
    - `faster-whisper`
    - `websockets`
    - `asyncio`
    (Do NOT create a virtual environment in the workspace, we will assume standard tooling will be used later, just define the requirements).
  </action>
  <verify>test -f pc_hub/requirements.txt && grep "faster-whisper" pc_hub/requirements.txt</verify>
  <done>pc_hub directory and requirements.txt exist with expected dependencies</done>
</task>

<task type="auto">
  <name>Implement Whisper WebSocket Service</name>
  <files>pc_hub/whisper_service.py, pc_hub/test_audio.py</files>
  <action>
    Create `whisper_service.py` in `pc_hub`.
    - Implement an `asyncio` WebSocket server listening on `0.0.0.0:8765`.
    - Initialize `faster-whisper` `WhisperModel` ("tiny.en" or "base.en", device="cpu" or "cuda" with compute_type="int8").
    - When a client connects and sends binary audio data (WAV frames), process it.
    - Because faster-whisper expects a file path or a complete numpy array, accumulate incoming chunks (or save them to a temporary in-memory `io.BytesIO` buffer formatted as WAV if required) and run transcription when a pause is detected or chunk is fully received. For simplicity, assume each incoming WebSocket message is a discrete audio chunk (e.g. 3-5 seconds long) in raw PCM or WAV format, save it to a temp file, run `.transcribe()`, and `print()` the result to the console.
    
    Create a simple `test_audio.py` script that acts as a mock client to send a raw audio file over WebSocket to test the server.
  </action>
  <verify>python -m py_compile pc_hub/whisper_service.py pc_hub/test_audio.py</verify>
  <done>whisper_service.py compiles and has a working websocket server structure initializing faster-whisper</done>
</task>

## Success Criteria
- [ ] `pc_hub/requirements.txt` exists with correct deps.
- [ ] `pc_hub/whisper_service.py` can start and initialize a `faster-whisper` model.
- [ ] `whisper_service.py` exposes a WebSocket server that receives audio chunks.
