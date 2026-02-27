# Quick Start: Speech Features for AI Tutor

## TL;DR - Get Started in 5 Minutes

### For Local Whisper (FREE - Recommended)

1. **Install whisper.cpp**:
   ```bash
   # Windows: Download from https://github.com/ggerganov/whisper.cpp/releases
   # macOS/Linux: Clone and build
   git clone https://github.com/ggerganov/whisper.cpp
   cd whisper.cpp
   make
   # Verify: whisper --version
   ```

2. **Backend Setup**:
   ```bash
   cd backend
   npm install
   ```

3. **Create `.env` file** (copy from .env.example):
   ```
   USE_LOCAL_WHISPER=true
   WHISPER_MODEL=base
   OLLAMA_HOST=http://localhost:11434
   ```

4. **Run Backend**:
   ```bash
   npm run dev
   ```

5. **Test Voice Input**:
   - Open AI Tutor in app
   - Click 🎤 microphone button
   - Speak your question
   - Click 🎤 again to transcribe
   - Text appears in input field ✅

### For OpenAI API (PAID - More Accurate)

1. **Get OpenAI API Key**:
   - Visit https://platform.openai.com/api-keys
   - Create new key
   - Copy it

2. **Backend Setup**:
   ```bash
   cd backend
   npm install
   ```

3. **Create `.env` file**:
   ```
   USE_LOCAL_WHISPER=false
   OPENAI_API_KEY=sk-your-key-here
   OLLAMA_HOST=http://localhost:11434
   ```

4. **Run Backend**:
   ```bash
   npm run dev
   ```

## Text-to-Speech (Both Options)

Already working! Toggle with speaker icon 🔊/🔇 in AI Tutor.

## Troubleshooting

### Microphone not working?
- Check Android/iOS audio permissions
- Restart the app
- Check backend is running

### Local Whisper errors?
- Verify `whisper` is in PATH: `which whisper` or `where whisper`
- Try smaller model: `WHISPER_MODEL=tiny`
- Check backend logs for details

### OpenAI errors?
- Verify API key is correct
- Check account has credits: https://platform.openai.com/account/billing/overview
- Check internet connection

## Features

✅ Voice input for disabled students
✅ Automatic speech recognition
✅ Full output text-to-speech
✅ No typing required
✅ Accessible UI with microphone button

## Files Modified

**Flutter**:
- `pubspec.yaml` - added `record` package
- `lib/services/speech_service.dart` - NEW
- `lib/features/offline_ai/offline_ai_screen.dart` - updated

**Backend**:
- `package.json` - added `form-data`
- `backend/speech.js` - NEW
- `backend/api.js` - added speech route
- `backend/.env.example` - configuration template

## Next Steps

1. Choose local or OpenAI
2. Follow setup above
3. Test microphone button
4. Enable TTS with speaker icon
5. Start tutoring!

## Need Help?

See `SPEECH_FEATURES.md` for detailed documentation and troubleshooting.

## Cost

- **Local Whisper**: FREE ✅
- **OpenAI API**: ~$0.02/minute

Enjoy the speech features! 🎤🔊
