import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_socket/src/models/messages_response.dart';
import 'package:flutter_chat_socket/src/services/auth_services.dart';
import 'package:flutter_chat_socket/src/services/chat_services.dart';
import 'package:flutter_chat_socket/src/services/socket_service.dart';
import 'package:flutter_chat_socket/src/widgets/chat_message.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _txtController = TextEditingController();
  final _focusNode = FocusNode();
  bool _writing = false;
  List<ChatMessage> _message = [];
  ChatService _chatService;
  SocketService _socketService;
  AuthServices _authServices;
  @override
  void initState() {
    super.initState();
    this._chatService = Provider.of<ChatService>(context, listen: false);
    this._socketService = Provider.of<SocketService>(context, listen: false);
    this._authServices = Provider.of<AuthServices>(context, listen: false);
    this._socketService.socket.on('send-message', _messageListening);
    _getHistoryMessages(this._chatService.toUser.uid);
  }

  _getHistoryMessages(String userId) async {
    List<Message> chat = await this._chatService.getChat(userId);
    final history = chat.map((e) => ChatMessage(
          textMessage: e.message,
          uid: e.from,
          animationController: AnimationController(
            vsync: this,
            duration: Duration(milliseconds: 0),
          )..forward(),
        ));
    setState(() {
      _message.insertAll(0, history);
    });
  }

  _messageListening(dynamic data) async {
    ChatMessage message = ChatMessage(
      uid: data['from'],
      textMessage: data['message'],
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      ),
    );

    setState(() {
      _message.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final user = this._chatService.toUser;
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
                user.name.substring(0, 2),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              maxRadius: 13,
              backgroundColor: Colors.blue[100],
            ),
            Text(
              user.name,
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

  _handleSubmit(String message) {
    if (message.length == 0) return;

    _txtController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessage(
      uid: _authServices.user.uid,
      textMessage: message.trim(),
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

    this._socketService.emit('send-message', {
      'from': _authServices.user.uid,
      'to': _chatService.toUser.uid,
      'message': message
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _message) {
      message.animationController.dispose();
    }
    this._socketService.socket.off('send-message');
    super.dispose();
  }
}
