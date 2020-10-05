import 'package:flutter/material.dart';
import 'package:flutter_chat_socket/src/models/user.dart';
import 'package:flutter_chat_socket/src/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final users = [];

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final user = authServices.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.black54,
          ),
          onPressed: () {
            //TODO: Desconectar el socket server
            AuthServices.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.check_circle,
              color: Colors.blue[300],
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        onRefresh: _getUsers,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[100],
          ),
          waterDropColor: Colors.blue[400],
        ),
        controller: _refreshController,
        child: _listViewUsers(),
      ),
    );
  }

  ListView _listViewUsers() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _userListTile(users[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: users.length);
  }

  ListTile _userListTile(User user) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          user.name.substring(0, 2),
        ),
        backgroundColor: Colors.blue[100],
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.name),
          Text(
            user.email,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: user.online ? Colors.blue : Colors.red,
        ),
      ),
    );
  }

  void _getUsers() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
