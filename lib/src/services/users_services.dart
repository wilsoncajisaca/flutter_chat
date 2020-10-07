import 'package:flutter_chat_socket/src/global/environment.dart';
import 'package:flutter_chat_socket/src/models/user.dart';
import 'package:flutter_chat_socket/src/models/users_response.dart';
import 'package:flutter_chat_socket/src/services/auth_services.dart';
import 'package:http/http.dart' as http;

class UsersServices {
  Future<List<User>> getUsers() async {
    try {
      final resp = await http.post(
        '${Environment.apiUrl}/user/',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthServices.getToken()
        },
      );
      final UsersResponse usersResponse = usersResponseFromJson(resp.body);
      return usersResponse.data;
    } catch (err) {
      return [];
    }
  }
}
