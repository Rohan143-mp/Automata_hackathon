/// AI configuration for HealthGuard — powered by Google Gemini.
class AiConfig {
  static const String geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');
  static const String model = 'gemini-1.5-flash';

  static String get baseUrl =>
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$geminiApiKey';
}
