import 'package:flutter/material.dart';
import 'package:flutter_chat_socket/src/pages/chat_page.dart';
import 'package:flutter_chat_socket/src/pages/user_page..dart';

import 'src/commons/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: UserPage(),
      routes: appRoutes,
    );
  }
}
