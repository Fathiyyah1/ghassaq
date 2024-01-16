import 'package:flutter/material.dart';
import 'package:ghassaq/utils/api.dart'; // Replace with the actual filename

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatGPTService chatGPTService = ChatGPTService(
      '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'); // Replace with your actual API key
  TextEditingController messageController = TextEditingController();
  List<String> chatMessages = [];

  void sendMessage() async {
    String userMessage = messageController.text;
    setState(() {
      chatMessages.add('User: $userMessage');
    });
    messageController.clear();

    String chatGPTResponse = await chatGPTService.getChatResponse(userMessage);
    setState(() {
      chatMessages.add('ChatGPT: $chatGPTResponse');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatMessages[index]),
                );
              },
            ),
          ),
          TextField(
            controller: messageController,
            decoration: InputDecoration(
              hintText: 'Type a message...',
            ),
            onSubmitted: (message) => sendMessage(),
          ),
          ElevatedButton(
            onPressed: sendMessage,
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}
