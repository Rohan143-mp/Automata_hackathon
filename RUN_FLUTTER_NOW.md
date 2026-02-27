# 🚀 RUN FLUTTER APP NOW

## ✅ Backend Status
**Server is RUNNING at http://0.0.0.0:3000** ✅

Backend is ready for voice features!

---

## 📱 Run Flutter App

### Step 1: Enable Developer Mode (One-time)

**Open Settings:**
```
start ms-settings:developers
```

**Enable "Developer Mode":**
- Search: "Developer Mode"
- Toggle: ON
- Accept warning

---

### Step 2: Open PowerShell

Press `Win+X` → Select "Windows Terminal" or "PowerShell"

---

### Step 3: Run Flutter App

```powershell
cd D:\GIT\Automata_hackathon\healthguard_app

flutter clean
flutter pub get
flutter run -d HD1901
```

**Or all in one command:**
```powershell
cd D:\GIT\Automata_hackathon\healthguard_app && flutter clean && flutter pub get && flutter run -d HD1901
```

---

## ⏳ What to Expect

1. **flutter clean** (10-20 seconds)
   - Clears build artifacts

2. **flutter pub get** (10-30 seconds)
   - Downloads dependencies
   - You'll see "Got dependencies!"

3. **flutter run -d HD1901** (30-60 seconds)
   - Compiles app
   - Installs on device
   - App launches
   - You see "App started" or similar

---

## 🎯 Once App Starts

1. **Navigate to AI Tutor** screen
2. **Click** 🎤 microphone button
3. **Speak:** "Hello, what is machine learning?"
4. **Click** 🎤 again to stop
5. **Wait** for transcription (first time: 1-2 min)
6. **See** transcribed text ✅
7. **Click Send** button
8. **See** tutor response
9. **Click** 🔊 speaker button
10. **Hear** response read aloud ✅

---

## ✅ Checklist

Before running:
- [ ] Developer Mode enabled: `start ms-settings:developers`
- [ ] Backend running: Check server window shows "Server is running"
- [ ] Device connected: `adb devices` shows HD1901
- [ ] PowerShell open
- [ ] In app directory: `cd D:\GIT\Automata_hackathon\healthguard_app`

Ready to go:
- [ ] Run: `flutter clean && flutter pub get && flutter run -d HD1901`

---

## 🔍 Monitor Both

**Keep TWO windows open:**

**Window 1: Backend Server**
```
Server is running at http://0.0.0.0:3000
Database initialized
```
(Already running - keep this open!)

**Window 2: Flutter App**
```
flutter run -d HD1901
```
(Watch for compilation progress and app launch)

---

## ❌ If Something Goes Wrong

### "Developer Mode not enabled"
Solution:
```
start ms-settings:developers
```
Toggle it ON, then retry Flutter run.

### "Device not found"
Solution:
```powershell
# Check connected devices
adb devices

# Should show: HD1901 device_name
```

### "Port 3000 already in use"
Solution: Backend is running (expected)
- This is fine - it means backend is working
- Continue with Flutter run

### "Failed to build"
Solution:
```powershell
cd D:\GIT\Automata_hackathon\healthguard_app
flutter clean
flutter pub get
flutter run -d HD1901
```

---

## 📊 Timeline

```
Now:
├─ Backend running ✅
├─ Developer Mode: Enable
└─ Run Flutter: 1-2 minutes
   ├─ clean: 20 sec
   ├─ pub get: 30 sec
   └─ run: 60 sec

Total: 2-3 minutes to running app
```

---

## 🎉 Success When...

- ✅ App launches on device
- ✅ See AI Tutor screen
- ✅ See 🎤 microphone button
- ✅ See 🔊 speaker button
- ✅ Click mic and speak → text appears
- ✅ Click speaker → hear response

---

## 🚀 Ready?

```powershell
cd D:\GIT\Automata_hackathon\healthguard_app
flutter clean && flutter pub get && flutter run -d HD1901
```

**GO!** 🎤🔊

(Backend is already running, just start Flutter!)
