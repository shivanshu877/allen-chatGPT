import 'dart:convert';

import 'package:allen/secret.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = [];
  String content = '';
  Future<String> chatGPTAPI(String prompt) async {
    try {
      final res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openAiAPIKey',
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {"role": "user", "content": "$prompt"}
            ]
          }));
      print(res.body);
      if (res.statusCode == 200) {
        content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        messages.add({
          'role': 'assistant',
          'content': content,
        });
      }
      return content;
    } catch (e) {
      return e.toString();
    }
    return content;
  }
}
