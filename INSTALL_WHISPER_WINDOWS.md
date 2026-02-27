# Install Whisper.cpp on Windows 11

## Option 1: Quick Install (Recommended - 2 minutes)

### Step 1: Download Pre-built Binary
1. Go to: https://github.com/ggerganov/whisper.cpp/releases
2. Download the latest **`whisper-bin.zip`** (Windows binary)
3. Extract to a folder, e.g., `C:\whisper\` or `C:\Program Files\whisper\`

### Step 2: Add to System PATH
1. **Right-click Start Menu → System**
2. **Click "Advanced system settings"** (or search "Environment Variables")
3. **Click "Environment Variables" button**
4. Under "User variables" or "System variables", click **"New"** or select **"Path"** → **"Edit"**
5. **Add:** `C:\whisper` (or wherever you extracted it)
6. Click **OK** multiple times

### Step 3: Verify Installation
Open Command Prompt or PowerShell:
```bash
whisper --version
```

Should show: `whisper version X.X.X`

---

## Option 2: Build from Source (Advanced - 15 minutes)

### Prerequisites
- Git: https://git-scm.com/download/win
- Visual Studio Build Tools or MinGW

### Step 1: Clone Repository
```bash
git clone https://github.com/ggerganov/whisper.cpp
cd whisper.cpp
```

### Step 2: Build
**For MinGW:**
```bash
make
```

**For MSVC (Visual Studio):**
```bash
mkdir build
cd build
cmake ..
cmake --build . --config Release
cd ..
```

### Step 3: Add to PATH
Copy `whisper.exe` (from `build/Release/` or root) to somewhere in PATH, or add the folder to PATH.

---

## Option 3: Use WSL (Windows Subsystem for Linux)

If you have WSL2 installed:

```bash
# Inside WSL:
curl https://sh.rustup.rs -sSf | sh
git clone https://github.com/ggerganov/whisper.cpp
cd whisper.cpp
make

# Then use the WSL path or copy to Windows
```

---

## Troubleshooting

### "whisper: command not found" after installation
- Restart your terminal/command prompt
- Verify PATH contains the whisper folder: `echo %PATH%`
- Try full path: `C:\whisper\whisper --version`

### First Run is Slow
- Whisper downloads model (~140MB) on first use
- For `base` model: ~2 minutes
- For `tiny` model: ~100MB, ~1 minute
- For `small`, `medium`, `large`: correspondingly larger

### Build Errors
- Make sure Visual Studio Build Tools are installed
- Or use pre-built binary (Option 1) instead

---

## After Installation

Once installed and verified:

1. **Create backend/.env** (already done):
   ```
   USE_LOCAL_WHISPER=true
   WHISPER_MODEL=base
   ```

2. **Install dependencies:**
   ```bash
   cd backend
   npm install
   ```

3. **Run backend:**
   ```bash
   npm run dev
   ```

4. **Test voice input in AI Tutor:**
   - Click 🎤 microphone button
   - Speak your question
   - Click 🎤 again to transcribe

---

## Quick Test

After installation, test whisper:

```bash
# Create a test audio file or use your microphone
whisper "path/to/audio.wav" --model base --output_format json

# Should output transcribed text
```

---

## Cost & Performance

| Model | Size | Speed | Accuracy |
|-------|------|-------|----------|
| tiny | 75MB | Fast ⚡ | 95% |
| base | 140MB | Good ⚡⚡ | 98% |
| small | 466MB | Slower ⚡⚡⚡ | 99% |
| medium | 1.4GB | Slow ⚡⚡⚡⚡ | 99.5% |
| large | 3.1GB | Very Slow | 99.9% |

**Recommended:** `base` (good balance of speed and accuracy)

---

## Support

If installation fails:
1. Check GitHub issues: https://github.com/ggerganov/whisper.cpp/issues
2. Use **Option 1** (pre-built binary) - simplest
3. Fall back to OpenAI API if needed (edit `.env` and set `USE_LOCAL_WHISPER=false`)
