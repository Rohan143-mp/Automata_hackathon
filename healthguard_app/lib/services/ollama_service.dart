import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Service to communicate with a local Ollama LLM instance.
/// Works offline — no internet required, just Ollama running on the host.
class OllamaService {
  /// Android emulator uses 10.0.2.2 to reach host's localhost.
  /// Physical devices on the same Wi-Fi should use the PC's LAN IP.
  static const String _emulatorHost = 'http://10.0.2.2:11434';
  static const String _defaultHost = 'http://localhost:11434';
  static const String modelName = 'deepseek-r1:8b';

  static const String _systemPrompt =
      'You are a helpful offline health assistant running on private hardware. '
      'Answer health-related questions clearly and concisely. '
      'Be empathetic. Never diagnose. Always suggest consulting a doctor for serious concerns. '
      'Keep responses under 200 words.';

  String get _baseUrl {
    // On Android emulator, 10.0.2.2 maps to the host machine's localhost
    if (Platform.isAndroid) return _emulatorHost;
    return _defaultHost;
  }

  /// Check if Ollama is reachable.
  Future<bool> checkConnection() async {
    try {
      final uri = Uri.parse('$_baseUrl/api/tags');
      final response = await http.get(uri).timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Send a chat message to Ollama and return the response text.
  Future<String> sendMessage(String userMessage) async {
    final uri = Uri.parse('$_baseUrl/api/generate');
    final payload = {
      'model': modelName,
      'prompt': '$_systemPrompt\n\nUser: $userMessage\nAssistant:',
      'stream': false,
    };

    try {
      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = (data['response'] ?? '').toString().trim();
        return text.isNotEmpty
            ? text
            : 'Sorry, I could not generate a response.';
      } else {
        return 'Ollama returned status ${response.statusCode}. '
            'Make sure the model "$modelName" is pulled.';
      }
    } catch (e) {
      return 'Could not reach Ollama. Make sure it is running on your PC.\n\nError: $e';
    }
  }
}
