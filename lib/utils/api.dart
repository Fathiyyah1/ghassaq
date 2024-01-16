import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPTService {
  String apiKey = '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';

  ChatGPTService(this.apiKey);

  Future<String> getChatResponse(String message) async {
    final apiUrl = 'https://api.openai.com/v1/chat/completions'; // Updated URL
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final body = jsonEncode({
      'messages': [
        {'role': 'system', 'content': 'You are a helpful assistant.'},
        {'role': 'user', 'content': message},
      ],
      'model': 'davinci-002', // Specify the model here
    });

    final response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      return decodedResponse['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to get response from ChatGPT.');
    }
  }
}
