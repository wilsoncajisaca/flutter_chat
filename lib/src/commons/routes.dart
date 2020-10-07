import 'package:flutter/material.dart';
import 'package:flutter_chat_socket/src/pages/chat_page.dart';
import 'package:flutter_chat_socket/src/pages/login_page.dart';
import 'package:flutter_chat_socket/src/pages/register_page.dart';
import 'package:flutter_chat_socket/src/pages/splash_page.dart';
import 'package:flutter_chat_socket/src/pages/user_page..dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': (_) => LoginPage(),
  'users': (_) => UserPage(),
  'register': (_) => RegisterPage(),
  'chat': (_) => ChatPage(),
  'splash': (_) => SplashPage(),
};
