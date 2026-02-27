import 'package:flutter/material.dart';
import '../../services/ollama_service.dart';

class OfflineAiScreen extends StatefulWidget {
  const OfflineAiScreen({super.key});

  @override
  State<OfflineAiScreen> createState() => _OfflineAiScreenState();
}

class _OfflineAiScreenState extends State<OfflineAiScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final OllamaService _ollama = OllamaService();
  final List<_ChatMessage> _messages = [];

  bool _isLoading = false;
  bool _isConnected = false;
  bool _isCheckingConnection = true;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    _addBotMessage(
      '👋 Hi! I\'m your **Offline AI** assistant powered by '
      '${OllamaService.modelName}.\n\n'
      'I run entirely on your local machine — no internet needed.\n\n'
      'Ask me anything about health, wellness, or your vitals!',
    );
  }

  Future<void> _checkConnection() async {
    if (mounted) setState(() => _isCheckingConnection = true);
    final connected = await _ollama.checkConnection();
    if (mounted) {
      setState(() {
        _isConnected = connected;
        _isCheckingConnection = false;
      });
    }
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(_ChatMessage(role: _Role.assistant, content: text));
    });
    _scrollToBottom();
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(_ChatMessage(role: _Role.user, content: text));
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    final reply = await _ollama.sendMessage(text);

    if (mounted) {
      // Strip <think>...</think> tags from deepseek-r1 reasoning
      final cleaned = reply.replaceAll(RegExp(r'<think>[\s\S]*?</think>'), '').trim();
      _addBotMessage(cleaned.isNotEmpty ? cleaned : reply);
      setState(() => _isLoading = false);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 380;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        // ── Connection banner ──────────────────────────────────────
        _buildConnectionBanner(colorScheme),

        // ── Messages ───────────────────────────────────────────────
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 10 : 14,
              vertical: 12,
            ),
            itemCount: _messages.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _messages.length && _isLoading) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Thinking locally…',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final msg = _messages[index];
              final isUser = msg.role == _Role.user;

              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmall ? 14 : 18,
                    vertical: isSmall ? 10 : 12,
                  ),
                  constraints: BoxConstraints(maxWidth: size.width * 0.78),
                  decoration: BoxDecoration(
                    color: isUser
                        ? colorScheme.primaryContainer
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    msg.content,
                    style: TextStyle(
                      fontSize: isSmall ? 15 : 16,
                      height: 1.4,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // ── Input area ─────────────────────────────────────────────
        Container(
          padding: EdgeInsets.all(isSmall ? 8 : 12),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: _isConnected
                        ? 'Ask your offline AI…'
                        : 'Ollama not connected…',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: isSmall ? 12 : 14,
                    ),
                  ),
                  enabled: _isConnected,
                  maxLines: 4,
                  minLines: 1,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed:
                    (_isLoading || !_isConnected) ? null : _sendMessage,
                icon: const Icon(Icons.send),
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConnectionBanner(ColorScheme colorScheme) {
    if (_isCheckingConnection) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        color: Colors.orange.shade50,
        child: Row(
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.orange.shade700,
              ),
            ),
            const SizedBox(width: 8),
            const Text('Checking Ollama connection…',
                style: TextStyle(fontSize: 13)),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: _checkConnection,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        color: _isConnected ? Colors.green.shade50 : Colors.red.shade50,
        child: Row(
          children: [
            Icon(
              _isConnected ? Icons.check_circle : Icons.error_outline,
              size: 16,
              color: _isConnected
                  ? Colors.green.shade700
                  : Colors.red.shade700,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _isConnected
                    ? 'Ollama connected • ${OllamaService.modelName}'
                    : 'Ollama offline — tap to retry',
                style: TextStyle(
                  fontSize: 13,
                  color: _isConnected
                      ? Colors.green.shade800
                      : Colors.red.shade800,
                ),
              ),
            ),
            if (!_isConnected)
              Icon(Icons.refresh, size: 16, color: Colors.red.shade600),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

// ── Private data types ────────────────────────────────────────────────────────

enum _Role { user, assistant }

class _ChatMessage {
  final _Role role;
  final String content;
  const _ChatMessage({required this.role, required this.content});
}
