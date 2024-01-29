import 'dart:convert';
import 'dart:developer'; // Import para usar log
import 'package:http/http.dart' as http;
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatService {
  final String apiUrl;
  final ChatUser bot;

  ChatService({required this.apiUrl, required this.bot});

  Future<ChatMessage?> sendMessage(String messageText) async {
    var data = {
      "contents": [
        {
          "parts": [
            {"text": messageText}
          ]
        }
      ]
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['candidates'] != null && result['candidates'].isNotEmpty) {
          var content = result['candidates'][0]['content'];
          if (content != null &&
              content['parts'] != null &&
              content['parts'].isNotEmpty) {
            String botResponseText = content['parts'][0]['text'];
            return ChatMessage(
              text: botResponseText,
              user: bot,
              createdAt: DateTime.now(),
            );
          } else {
            log('Content parts not found');
            return null;
          }
        } else {
          log('No candidates found in response');
          return null;
        }
      } else {
        log('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }
}
