import 'package:flutter/material.dart';
import 'package:flutter_chat_socket/src/pages/splash_page.dart';
import 'package:flutter_chat_socket/src/services/auth_services.dart';
import 'package:flutter_chat_socket/src/services/chat_services.dart';
import 'package:flutter_chat_socket/src/services/socket_service.dart';
import 'package:provider/provider.dart';

import 'src/commons/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: SplashPage(),
        routes: appRoutes,
      ),
    );
  }
}
