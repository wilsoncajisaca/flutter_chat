import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_socket/src/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _txtController = TextEditingController();
  final _focusNode = FocusNode();
  bool _writing = false;
  List<ChatMessage> _message = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black54,
        ),
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                'Wi',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              maxRadius: 13,
              backgroundColor: Colors.blue[100],
            ),
            Text(
              "Wilson Cajisaca",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemBuilder: (_, i) => _message[i],
                reverse: true,
                itemCount: _message.length,
                physics: BouncingScrollPhysics(),
              ),
            ),
            Divider(),
            Container(
              height: 50,
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _txtController,
                onSubmitted: _handleSubmit,
                onChanged: (texto) {
                  setState(() {
                    if (texto.trim().length > 0) {
                      _writing = true;
                    } else {
                      _writing = false;
                    }
                  });
                },
                decoration: InputDecoration(hintText: 'Escriba un mensaje'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text("Enviar"),
                      onPressed: _writing
                          ? () => _handleSubmit(_txtController.text)
                          : null,
                    )
                  : IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.send),
                        onPressed: _writing
                            ? () => _handleSubmit(_txtController.text)
                            : null,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String txt) {
    if (txt.length == 0) return;

    _txtController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessage(
      uid: '123',
      textMessage: txt.trim(),
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 450),
      ),
    );
    _message.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _writing = false;
    });
  }

  @override
  void dispose() {
    // TODO: off socket
    for (ChatMessage message in _message) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
