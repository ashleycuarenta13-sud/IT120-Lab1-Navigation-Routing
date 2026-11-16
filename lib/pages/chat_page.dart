// CHAT PAGE: real-time messages using a WebSocket
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../my_name.dart';

// A small class that remembers ONE chat message
class ChatMessage {
  final String text;
  final bool fromMe; // true = I sent it, false = the server sent it
  ChatMessage(this.text, this.fromMe);
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // 1. CONNECT: open the line to the echo server
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.org'),
  );
  final msgCtrl = TextEditingController();
  final List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    // 3. LISTEN: this runs EVERY time the server sends something
    channel.stream.listen(
      (data) {
        if (!mounted) return; // the page is already closed
        setState(() => messages.add(ChatMessage('$data', false)));
      },
      onError: (error) {
        if (!mounted) return;
        final text = 'Connection error: $error';
        setState(() => messages.add(ChatMessage(text, false)));
      },
    );
    channel.ready.catchError((error) {
      if (!mounted) return;
      setState(() => messages.add(ChatMessage('Connection error: $error', false)));
    });
    // TWIST B: greet the server automatically
    channel.sink.add('Hi! I am $studentName');
  }

  // 2. SEND: put my text into the open line
  void send() {
    final String text = msgCtrl.text.trim();
    if (text.isEmpty) return;
    channel.sink.add(text.toUpperCase()); // TWIST A
    setState(() => messages.add(ChatMessage(text, true)));
    msgCtrl.clear();
  }

  // 4. CLOSE the line when we leave the page
  @override
  void dispose() {
    channel.sink.close();
    msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Chat - $studentName')),
      body: Column(
        children: [
          // The list of messages (takes all the free space)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final m = messages[index];
                return Align(
                  // my messages on the RIGHT, server messages on the LEFT
                  alignment:
                      m.fromMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: m.fromMe
                          ? Colors.indigo.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      m.fromMe ? 'Me: ${m.text}' : 'Server: ${m.text}',
                    ),
                  ),
                );
              },
            ),
          ),
          // The input row at the bottom
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: msgCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => send(), // Enter key also sends
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  icon: const Icon(Icons.send),
                  onPressed: send,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}