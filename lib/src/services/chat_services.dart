import 'package:flutter/material.dart';
import 'package:flutter_chat_socket/src/global/environment.dart';
import 'package:flutter_chat_socket/src/models/messages_response.dart';
import 'package:flutter_chat_socket/src/models/user.dart';
import 'package:flutter_chat_socket/src/services/auth_services.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  User toUser;
  Future<List<Message>> getChat(String userId) async {
    final resp = await http.get(
      '${Environment.apiUrl}/messages/$userId',
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthServices.getToken()
      },
    );
    final messagesResp = messagesResponseFromJson(resp.body);
    return messagesResp.messages;
  }
}
