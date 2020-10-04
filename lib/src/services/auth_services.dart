import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_socket/src/global/environment.dart';
import 'package:flutter_chat_socket/src/models/login_response.dart';
import 'package:flutter_chat_socket/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthServices with ChangeNotifier {
  User user;
  bool _autenticando = false;

  bool get autenticando => this._autenticando;
  set autenticando(bool value) {
    this._autenticando = value;
    notifyListeners();
  }

  Future login(String email, String password) async {
    this.autenticando = true;

    final data = {
      'email': email,
      'password': password,
    };

    final res = await http.post(
      '${Environment.apiUrl}/login',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(res.body);
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.user = loginResponse.data;
    }
    this.autenticando = false;
  }
}
