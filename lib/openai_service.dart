import 'dart:convert';

import 'package:allen/secerets.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apikey'
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            'message': [
              {
                'role': 'user',
                'content':
                    'Does this message want to genrate an AI picture,image,art or anything similar?$prompt . Simply answer with yes or no.'
              }
            ]
          }));
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        switch (content) {
          case 'yes':
          case 'Yes':
          case 'Yes.':
          case 'yes.':
            final res = await dalEAPI(prompt);
            return res;
          default:
            final res = await chatGPTAPI(prompt);
            return res;
        }
      }
      return 'an internal error occured';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    return 'chatgpt';
  }

  Future<String> dalEAPI(String prompt) async {
    return 'DALL-E';
  }
}
