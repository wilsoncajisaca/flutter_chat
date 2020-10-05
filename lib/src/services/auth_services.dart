import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_socket/src/global/environment.dart';
import 'package:flutter_chat_socket/src/models/login_response.dart';
import 'package:flutter_chat_socket/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthServices with ChangeNotifier {
  User user;
  bool _autenticando = false;
  final _storage = FlutterSecureStorage();
  String _messageError;

  bool get autenticando => this._autenticando;
  String get messageError => this._messageError;

  set autenticando(bool value) {
    this._autenticando = value;
    notifyListeners();
  }

  //Getters del token de forma estatica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
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

    this.autenticando = false;
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.user = loginResponse.data;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    this.autenticando = true;
    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    final res = await http.post(
      '${Environment.apiUrl}/login/new',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    this.autenticando = false;
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.user = loginResponse.data;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(res.body);
      this._messageError = respBody['msg'];
      return false;
    }
  }

  Future<bool> isLoogedIn() async {
    final token = await _storage.read(key: 'token');

    final res = await http.get(
      '${Environment.apiUrl}/login/renew',
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      },
    );
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.user = loginResponse.data;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      this._logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _logout() async {
    await _storage.delete(key: 'token');
  }
}
