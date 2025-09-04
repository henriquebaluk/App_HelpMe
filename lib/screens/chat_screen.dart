
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final title = args?['title'] ?? 'Chat';

    return Scaffold(
      appBar: AppBar(title: Text(title.toString())),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (_, i){
                final m = _messages[i];
                final isMe = m['me'] as bool;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.green.shade600 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      m['text'] as String,
                      style: TextStyle(color: isMe ? Colors.white : Colors.black87),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Escreva uma mensagem...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if(_controller.text.trim().isEmpty) return;
                      setState(() {
                        _messages.add({'text': _controller.text.trim(), 'me': true});
                      });
                      _controller.clear();
                      // resposta simulada
                      Future.delayed(const Duration(milliseconds: 500), (){
                        setState(() {
                          _messages.add({'text': 'Recebi sua mensagem! Vamos combinar 😉', 'me': false});
                        });
                      });
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
