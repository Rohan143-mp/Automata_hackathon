# 🚀 START YOUR BACKEND SERVER NOW

## Step 1: Install Whisper (ONE TIME - 2 minutes)

### Download & Install
1. Go to: https://github.com/ggerganov/whisper.cpp/releases
2. Download `whisper-bin.zip` (scroll to find it)
3. Extract to: `C:\whisper`
4. Add to PATH:
   - Press `Win+X` → System
   - Click "Advanced system settings"
   - Click "Environment Variables"
   - Click "New" under "User variables"
   - Variable name: `Path`
   - Variable value: `C:\whisper`
   - Click OK, OK, OK
   - **Close and reopen Command Prompt**

### Verify
```cmd
whisper --version
```
Should show version number. If not, restart your PC.

---

## Step 2: Start Backend Server (RIGHT NOW)

### Option A: Using Windows PowerShell (EASIEST)

**Open PowerShell:**
1. Press `Win+X` and select "Windows Terminal" or "PowerShell"
2. Type:
```powershell
cd D:\GIT\Automata_hackathon\backend
.\run-server.bat
```

3. You should see:
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

**Keep this window OPEN while testing**

### Option B: Using NPM Command

```powershell
cd D:\GIT\Automata_hackathon\backend
npm run dev
```

---

## Step 3: Test Backend is Running (New Terminal)

**Open a NEW PowerShell window** while the server is running:

```powershell
# Test basic connection
curl http://localhost:3000/

# Should return: "Nodemon is watching for changes!"
```

---

## Step 4: Test Voice Input in App

### With Backend Running:

1. **Open Flutter app** on emulator or phone
2. **Go to AI Tutor** screen
3. **Click** 🎤 microphone button
4. **Speak clearly**: "What is artificial intelligence?"
5. **Click** 🎤 again (stop recording)
6. **Wait** for transcription
   - First time: ~2 minutes (downloading model)
   - Next times: 2-5 seconds
7. **See** transcribed text in input field ✅

### Test Text-to-Speech

1. **Click** 🔊 speaker button to enable TTS
2. **Type or speak** any question
3. **Click Send**
4. **Hear** the tutor's response read aloud ✅

---

## ✅ Checklist: You're Ready When...

- [ ] Whisper installed: `whisper --version` works
- [ ] Backend running: See "Server is running at http://0.0.0.0:3000"
- [ ] Backend responds: `curl http://localhost:3000/` returns success
- [ ] App opens: AI Tutor screen loads
- [ ] Voice button visible: 🎤 appears in input area
- [ ] Speaker button visible: 🔊 appears in toolbar

---

## 🆘 Quick Troubleshooting

### "whisper: command not found"
- Download whisper-bin.zip again
- Make sure you added C:\whisper to PATH
- Restart your computer
- Try `whisper --version` again

### Backend won't start
```powershell
cd D:\GIT\Automata_hackathon\backend
npm install
npm run dev
```

### "Failed to transcribe" in app
- Check backend is running (look at terminal)
- Give microphone permission in app
- Try again (first attempt is slow)

### Microphone button doesn't appear
- Rebuild/rerun Flutter app
- Check internet connection to backend
- Check backend is on localhost:3000

---

## 📊 Performance Timeline

**First Time Run:**
- 0s: Click mic button
- 0-5s: Recording
- 5s: Click mic button to stop
- 5-120s: Download model + transcribe (slow!)
- 120s+: Text appears

**Subsequent Runs:**
- 0s: Click mic
- 0-5s: Record
- 5s: Click mic
- 5-10s: Transcribe
- 10s+: Text appears

**After Warmup:**
- Recording + Transcription: ~10 seconds total

---

## 🎯 What's Running

```
Your Machine:
├── Windows PowerShell
│   └── Node.js Backend Server (port 3000)
│       ├── Speech endpoint: /speech/transcribe
│       ├── Ollama proxy: /ollama/*
│       ├── Patient API: /patient/*
│       └── Doctor API: /doctor/*
│
├── Whisper.cpp (local binary)
│   └── Transcribes audio (called by speech endpoint)
│
├── Flutter App (on emulator or phone)
│   └── AI Tutor with voice input 🎤
│
└── Ollama (if running)
    └── Language model: llama3.2:3b
```

---

## 📞 Still Need Help?

**Error from backend?**
- Look at error message in terminal
- Check `.env` file: `cat backend\.env`
- Check whisper is installed: `whisper --version`

**Error in app?**
- Check backend is running
- Check app has microphone permission
- Look at backend logs for transcription errors

**Files to check:**
- `backend/.env` - Configuration
- `backend/speech.js` - Speech endpoint code
- `backend/api.js` - Server setup
- `healthguard_app/lib/services/speech_service.dart` - Flutter voice code

---

## 🎉 Next Steps After Success

1. Commit your changes:
```bash
git add .
git commit -m "feat: implement openai whisper speech-to-text and tts for disabled students"
```

2. Deploy:
- Ensure whisper is installed on production server
- Update production `.env` with correct settings
- Run `npm run dev` or use process manager (PM2)

3. Monitor:
- Check speech transcription accuracy
- Monitor CPU usage (Whisper is CPU-intensive)
- Collect user feedback on voice input

---

**Ready? Open Terminal and run:**
```powershell
cd D:\GIT\Automata_hackathon\backend
.\run-server.bat
```

**GO! 🚀**
