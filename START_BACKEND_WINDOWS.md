# 🚀 START BACKEND SERVER - WINDOWS

**Your Setup:**
✅ Whisper downloaded: `C:\whisper-bin-x64`
✅ Added to PATH: Yes
✅ Backend ready: Yes
✅ Configuration: Done

---

## 🎯 START SERVER NOW

### Option 1: Using PowerShell (EASIEST)

1. **Open PowerShell:**
   - Press `Win+X` and select "Windows Terminal" or "PowerShell"

2. **Navigate to backend:**
   ```powershell
   cd D:\GIT\Automata_hackathon\backend
   ```

3. **Start server:**
   ```powershell
   npm run dev
   ```

4. **You should see:**
   ```
   Server is running at http://0.0.0.0:3000
   Database initialized
   ```

**Keep this window OPEN!** ← Important

---

### Option 2: Using Batch Script

1. **Open Command Prompt or PowerShell**

2. **Run the batch file:**
   ```powershell
   D:\GIT\Automata_hackathon\backend\run-server.bat
   ```

3. **You should see startup info and server running message**

---

## ✅ VERIFY SERVER IS RUNNING

**In a NEW PowerShell window** (keep the server window open):

```powershell
# Test connection
curl http://localhost:3000/

# Should return: "Nodemon is watching for changes!"
```

---

## 🧪 TEST WHISPER CONNECTION

**While server is running:**

```powershell
# Check if whisper is accessible
whisper --version

# Should show: whisper version X.X.X
```

---

## 📱 TEST IN FLUTTER APP

Once server is running:

1. **Open Flutter app** on emulator or device
2. **Go to AI Tutor** screen
3. **Click** 🎤 microphone button
4. **Speak clearly:** "Hello, what is artificial intelligence?"
5. **Click** 🎤 again to stop recording
6. **Wait** for transcription:
   - First time: 1-2 minutes (downloading 140MB model)
   - Next times: 2-5 seconds
7. **See** text appear: "Hello, what is artificial intelligence?"
8. **Click Send** button
9. **Click** 🔊 speaker button to hear tutor respond

---

## 🔧 CONFIGURATION

**Current setup in `.env`:**
```
USE_LOCAL_WHISPER=true
WHISPER_MODEL=base
OLLAMA_HOST=http://localhost:11434
```

**All configured correctly!** No changes needed.

---

## ❌ IF SOMETHING GOES WRONG

### Server won't start
```powershell
cd D:\GIT\Automata_hackathon\backend
npm install
npm run dev
```

### Whisper not found
```powershell
# Verify whisper is in PATH
whisper --version

# If not found:
# 1. Restart PowerShell
# 2. Check C:\whisper-bin-x64 exists
# 3. Check PATH includes C:\whisper-bin-x64
# 4. Try: C:\whisper-bin-x64\whisper --version
```

### Port 3000 already in use
```powershell
# Find what's using port 3000
netstat -ano | findstr :3000

# If needed, change port in backend/api.js line ~29
# Or kill the process using that port
```

### "Failed to transcribe audio" in app
- Ensure server is running (check terminal)
- Grant microphone permission in app
- Check backend logs for errors
- First run downloads model (very slow first time)

---

## 🎯 SUCCESS CHECKLIST

- [ ] PowerShell open
- [ ] Navigate to `D:\GIT\Automata_hackathon\backend`
- [ ] Run `npm run dev`
- [ ] See "Server is running at http://0.0.0.0:3000"
- [ ] Keep window open
- [ ] Test: `curl http://localhost:3000/`
- [ ] Open Flutter app
- [ ] See 🎤 microphone button in AI Tutor
- [ ] Click mic → Speak → Text appears ✅

---

## 📊 TIMELINE

**When you start:**
- 0 sec: `npm run dev`
- 5 sec: Server initializes
- 10 sec: "Server is running at http://0.0.0.0:3000"
- Ready: Can test immediately

**First voice test:**
- 0 sec: Click 🎤
- 5 sec: Speak for 5 seconds
- 10 sec: Click 🎤 again
- 10-130 sec: Download model + transcribe (SLOW first time!)
- 130+ sec: Text appears ✅

**Next voice tests:**
- 0 sec: Click 🎤
- 5 sec: Speak
- 10 sec: Click 🎤
- 10-15 sec: Transcribe
- 15+ sec: Text appears ✅

---

## 💡 TIPS

**Keep server running:**
- Don't close the PowerShell window
- Use another window for testing
- Server runs until you press Ctrl+C

**Fast development:**
- Server auto-reloads on file changes
- No restart needed for code changes
- Just modify and save

**Monitor requests:**
- Watch PowerShell for logs
- See requests coming in
- Check for errors

---

## 🆘 NEED HELP?

**Check:**
1. `START_SERVER_NOW.md` - Detailed setup guide
2. `QUICK_REFERENCE.txt` - Quick commands
3. `SPEECH_FEATURES.md` - Complete documentation
4. Backend logs (in PowerShell window)

---

## 🎉 YOU'RE READY!

```powershell
cd D:\GIT\Automata_hackathon\backend
npm run dev
```

**That's it! Server will start and be ready for voice input!** 🚀

Keep the window open and start testing the voice features in your Flutter app! 🎤🔊
