# ✅ Setup Checklist - Local Whisper + Backend Server

## Phase 1: Install Whisper (ONE TIME ONLY)

- [ ] Download whisper.cpp from: https://github.com/ggerganov/whisper.cpp/releases
- [ ] Download `whisper-bin.zip` (pre-built Windows binary)
- [ ] Extract to: `C:\whisper` (or any folder)
- [ ] Add to System PATH:
  - Right-click Start → System → Environment Variables
  - Add `C:\whisper` to PATH
  - Restart Command Prompt/PowerShell
- [ ] **Verify**: Open Command Prompt, type `whisper --version`
  - Should show: `whisper version X.X.X`

**⏱️ Time: 2-3 minutes**

---

## Phase 2: Configure Backend (ALREADY DONE ✅)

- [x] `.env` file created with correct settings
  - `USE_LOCAL_WHISPER=true`
  - `WHISPER_MODEL=base`
  - `OLLAMA_HOST=http://localhost:11434`
- [x] Backend dependencies installed (`npm install`)
- [x] Speech endpoint created (`backend/speech.js`)
- [x] Startup scripts created:
  - `backend/run-server.bat` (Windows)
  - `backend/run-server.sh` (macOS/Linux)

**Status: ✅ READY TO RUN**

---

## Phase 3: Run Backend Server

### Option A: Using Startup Script (Windows)

**Open PowerShell or Command Prompt:**
```powershell
cd D:\GIT\Automata_hackathon\backend
.\run-server.bat
```

**You should see:**
```
============================================
HealthGuard Backend Server Startup
============================================

Current Configuration:
========================
USE_LOCAL_WHISPER=true
WHISPER_MODEL=base
OLLAMA_HOST=http://localhost:11434

Starting Node.js backend...
Server will run on: http://localhost:3000

Press Ctrl+C to stop the server
```

### Option B: Manual Start

**Open Command Prompt or PowerShell:**
```bash
cd D:\GIT\Automata_hackathon\backend
npm run dev
```

**Expected output:**
```
Server is running at http://0.0.0.0:3000
Database initialized
```

---

## Phase 4: Test the System

### Test 1: Backend is Running
```bash
# In another terminal/PowerShell
curl http://localhost:3000/
```
Should return: `Nodemon is watching for changes!`

### Test 2: Ollama Endpoint
```bash
curl http://localhost:3000/ollama/health
```
Should return: `{"ok":true}` (if Ollama is running)

### Test 3: Speech Endpoint (When Whisper is Ready)
```bash
# Using PowerShell (will test next)
```

---

## Phase 5: Test Voice Input in App

### Start the App
1. Open Flutter app (Android emulator or physical device)
2. Navigate to **AI Tutor** screen
3. You should see:
   - Text input field
   - 🎤 Microphone button (NEW!)
   - 🔊 Speaker button (TTS)

### Test Voice Input
1. **Click** 🎤 microphone button
2. **Speak** your question (e.g., "What is machine learning?")
3. **Click** 🎤 again to stop recording
4. **Wait** for transcription (first time is slow, ~2 seconds)
5. **See** transcribed text appear in input field
6. **Click** Send button

---

## Troubleshooting

### Problem: "whisper: command not found"
**Solution:**
1. Download whisper.cpp binary from GitHub releases
2. Extract to a folder
3. Add folder to System PATH
4. Restart terminal and verify: `whisper --version`

### Problem: Backend won't start
**Check:**
- [ ] Node.js is installed: `node --version`
- [ ] Dependencies installed: `npm install` in backend folder
- [ ] No other service on port 3000
- [ ] .env file exists and has correct settings

**Fix:**
```bash
cd backend
npm install
npm run dev
```

### Problem: "Failed to transcribe audio" in app
**Check:**
- [ ] Whisper is installed: `whisper --version`
- [ ] Backend is running on port 3000
- [ ] Microphone permissions granted in app
- [ ] Audio was recorded (wait for it to process)

### Problem: First voice input is very slow
**Expected behavior:**
- First run: Whisper downloads model (~140MB)
- Time: 1-2 minutes
- Subsequent requests: 2-5 seconds
- Use smaller model if needed: `WHISPER_MODEL=tiny`

---

## Configuration Options

### In `.env` file:

**Use Local Whisper (Current):**
```
USE_LOCAL_WHISPER=true
WHISPER_MODEL=base  # tiny, base, small, medium, large
```

**Switch to OpenAI API (if needed):**
```
USE_LOCAL_WHISPER=false
OPENAI_API_KEY=sk-your-key-here
```

---

## Key Files

```
d:\GIT\Automata_hackathon\
├── backend/
│   ├── .env                 ✅ Configuration
│   ├── api.js              ✅ Main server
│   ├── speech.js           ✅ Speech endpoint (NEW)
│   ├── package.json        ✅ Dependencies
│   ├── run-server.bat      ✅ Startup (Windows)
│   └── run-server.sh       ✅ Startup (macOS/Linux)
├── healthguard_app/
│   ├── lib/services/
│   │   └── speech_service.dart    ✅ Voice recording (NEW)
│   └── lib/features/offline_ai/
│       └── offline_ai_screen.dart ✅ Updated with 🎤 button
├── INSTALL_WHISPER_WINDOWS.md      ✅ Installation guide
├── QUICK_START_SPEECH.md           ✅ 5-min quickstart
└── SPEECH_FEATURES.md              ✅ Full documentation
```

---

## Next Steps

### Immediate (Right Now)
1. ✅ Install Whisper.cpp binary
2. ✅ Run `backend/run-server.bat` or `npm run dev`
3. ✅ Test 🎤 microphone button in app

### Soon
- [ ] Test full workflow with voice input
- [ ] Enable TTS with speaker button
- [ ] Record feedback and issues

### Optional
- [ ] Switch to smaller/larger Whisper model
- [ ] Switch to OpenAI API if needed
- [ ] Add custom TTS voice
- [ ] Deploy to production

---

## Support Commands

```bash
# Check whisper installation
whisper --version

# Check Node.js
node --version
npm --version

# Check if port 3000 is in use
netstat -ano | findstr :3000  # Windows

# View backend logs
# (already showing in terminal when running)

# Test API
curl http://localhost:3000/
```

---

## 🎯 Success Indicators

✅ Backend running: Terminal shows `Server is running at http://0.0.0.0:3000`
✅ Whisper ready: Can see 🎤 button in AI Tutor app
✅ Voice working: Click mic → speak → text appears
✅ TTS working: Click 🔊 → responses are read aloud

🎉 **You're all set!**
