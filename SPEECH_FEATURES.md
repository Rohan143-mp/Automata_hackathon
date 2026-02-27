# Speech-to-Text and Text-to-Speech Features

This document describes the accessibility features added for disabled students using the AI Tutor.

## Overview

The AI Tutor now includes:
1. **Speech-to-Text (Input)**: Use local Whisper or OpenAI Whisper API to convert voice to text
2. **Text-to-Speech (Output)**: Full output reading with Flutter TTS

## Features

### 1. Voice Input (Speech-to-Text)

**For disabled students** who cannot type, the AI Tutor now includes a microphone button in the input area.

#### How to Use:
1. Click the **🎤 microphone icon** in the input area
2. Speak your question or statement
3. Click the same button again to **stop recording**
4. The speech will be transcribed using OpenAI Whisper API
5. Your transcribed text will appear in the input field
6. Click send to ask the tutor

#### Technical Details:
- **Two transcription options**:
  - Local Whisper: Free, runs locally (no API key needed)
  - OpenAI Whisper API: Paid, more accurate
- Audio is recorded in WAV format at 16kHz
- Temporary audio files are automatically cleaned up
- Supports English language (configurable in backend)

### 2. Full Output Reading (Text-to-Speech)

**All tutor responses** can be automatically read aloud for accessibility.

#### How to Use:
1. Click the **speaker icon (🔊/🔇)** in the toolbar to toggle TTS on/off
2. When enabled, all tutor responses will be read aloud automatically
3. Text is processed to remove formatting and emojis for natural speech
4. Speech rate is optimized for clarity (slower than default)

#### Features:
- Automatically reads all AI tutor responses when enabled
- Cleans markdown formatting for better speech quality
- Removes emojis and replaces them with text descriptions
- Optimized speech rate (0.5) for clarity
- Uses English-US voice

## Setup Instructions

### Backend Setup

1. **Install Dependencies**:
   ```bash
   cd backend
   npm install
   ```

2. **Choose Your Transcription Method**:

   #### Option A: Local Whisper (RECOMMENDED - Free & Private)

   **Install whisper.cpp**:

   - Download from: https://github.com/ggerganov/whisper.cpp/releases
   - Extract and add to your PATH, or note the path
   - Verify installation: `whisper --version`

   **For Windows**:
   ```bash
   # Download whisper-bin.zip from releases
   # Extract to C:\whisper or add to PATH
   whisper --help
   ```

   **For macOS/Linux**:
   ```bash
   # Build from source
   git clone https://github.com/ggerganov/whisper.cpp
   cd whisper.cpp
   make
   # Add to PATH or use full path in .env
   ```

   #### Option B: OpenAI Whisper API (Paid - More Accurate)

   - Visit https://platform.openai.com/api-keys
   - Create a new API key
   - Keep this key secure!

3. **Configure Environment Variables**:
   ```bash
   cp .env.example .env
   ```

   **For Local Whisper** (recommended):
   ```
   USE_LOCAL_WHISPER=true
   WHISPER_MODEL=base  # tiny, base, small, medium, large
   ```

   **For OpenAI API**:
   ```
   USE_LOCAL_WHISPER=false
   OPENAI_API_KEY=sk-your-actual-key-here
   ```

4. **Start Backend**:
   ```bash
   npm run dev
   ```
   The speech endpoint will be available at `/speech/transcribe`

### Flutter App Setup

The app automatically includes the speech features. No additional setup needed beyond:

1. **Audio Permissions** (Android):
   Add to `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
   ```

2. **Audio Permissions** (iOS):
   Add to `ios/Runner/Info.plist`:
   ```xml
   <key>NSMicrophoneUsageDescription</key>
   <string>This app needs microphone access for voice input to the AI Tutor</string>
   ```

## API Endpoints

### POST `/speech/transcribe`
Transcribes audio file using either local Whisper or OpenAI Whisper API (configurable).

**Request**:
- `Content-Type`: multipart/form-data
- Body: Audio file (WAV format)

**Response**:
```json
{
  "text": "transcribed text from audio"
}
```

**Example Error**:
```json
{
  "error": "OpenAI API key not configured",
  "detail": "Set OPENAI_API_KEY environment variable"
}
```

## Architecture

### Option 1: Local Whisper (Recommended)
```
Flutter App (offline_ai_screen.dart)
    ↓
SpeechService (speech_service.dart)
    ↓ [Records audio locally]
Backend API (api.js → speech.js)
    ↓ [Sends audio file]
Local Whisper Binary (whisper.cpp)
    ↓ [Transcription on same machine]
Backend API
    ↓ [Returns JSON result]
Flutter App [Display transcribed text]
```

### Option 2: OpenAI Whisper API
```
Flutter App (offline_ai_screen.dart)
    ↓
SpeechService (speech_service.dart)
    ↓ [Records audio locally]
Backend API (api.js → speech.js)
    ↓ [Sends to OpenAI]
OpenAI Whisper API
    ↓ [Transcription]
Backend API
    ↓ [Returns JSON result]
Flutter App [Display transcribed text]
```

## Cost Considerations

**Local Whisper** (RECOMMENDED):
- ✅ FREE to use
- ✅ No API key required
- ✅ Runs completely offline
- ✅ Private - data never leaves your machine
- ⚠️ Slower than cloud API (first-time model download ~140MB)
- ⚠️ Requires more CPU resources

**OpenAI Whisper API**:
- 💰 $0.02 USD per minute of audio
- ✅ Very accurate and fast
- ✅ No local setup needed
- ⚠️ Requires internet and API key
- ⚠️ Data sent to OpenAI servers

**Recommendation for Production**:
- Use **Local Whisper** for education/non-profit (free + privacy)
- Use **OpenAI API** if you need maximum accuracy or can't install local tools
- Monitor API usage through OpenAI dashboard if using cloud option

## Troubleshooting

### Speech-to-Text Issues

**Problem**: Microphone button doesn't work
- Check Android/iOS audio permissions
- Ensure microphone is not in use by another app
- Check backend connectivity

**Problem**: "Failed to transcribe audio"
- If using **Local Whisper**:
  - Verify `whisper` binary is installed and in PATH
  - Check `WHISPER_MODEL` is set correctly
  - Try smaller model: `WHISPER_MODEL=tiny`
- If using **OpenAI API**:
  - Verify `OPENAI_API_KEY` is set in backend `.env`
  - Check internet connection
  - Check OpenAI account has credits/active subscription

**Problem**: Transcription is inaccurate
- Speak clearly and slowly
- Reduce background noise
- Use microphone button again for clearer audio

### Text-to-Speech Issues

**Problem**: Speaker doesn't read output
- Check system volume is not muted
- Toggle TTS off and on again
- Verify TTS language is set to English

**Problem**: Speech is too fast/slow
- TTS rate is fixed at 0.5 for clarity
- Can be adjusted in `offline_ai_screen.dart` line with `setSpeechRate()`

## Future Enhancements

- [ ] Support for multiple languages
- [ ] Voice commands for navigation
- [ ] Custom TTS voice selection
- [ ] Audio caching to reduce costs
- [ ] Offline speech recognition fallback
- [ ] Accessibility settings panel

## Files Changed

**Flutter App**:
- `pubspec.yaml` - Added `record` package
- `lib/services/speech_service.dart` - New speech service
- `lib/features/offline_ai/offline_ai_screen.dart` - UI integration

**Backend**:
- `package.json` - Added `form-data` package
- `backend/speech.js` - New speech endpoint
- `backend/api.js` - Mounted speech router
- `.env.example` - Configuration template

## Support

For issues or feature requests related to speech features, please refer to:
- OpenAI Whisper API docs: https://platform.openai.com/docs/api-reference/audio
- Flutter TTS package: https://pub.dev/packages/flutter_tts
- Record package: https://pub.dev/packages/record
