import 'package:flutter/material.dart';
import 'package:flutter_chat_socket/src/services/auth_services.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String textMessage;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    Key key,
    @required this.uid,
    @required this.textMessage,
    @required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context, listen: false);
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: this.uid == authServices.user.uid
              ? _myMessage()
              : _notMyMessage(),
        ),
      ),
    );
  }

  _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 35, right: 10),
        padding: EdgeInsets.all(8),
        child: Text(
          this.textMessage,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: Color(0xff4d9ef6),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 35),
        padding: EdgeInsets.all(8),
        child: Text(
          this.textMessage,
          style: TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
          color: Color(0xffe4e5e8),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
