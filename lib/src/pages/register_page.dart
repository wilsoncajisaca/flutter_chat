import 'package:flutter/material.dart';
import 'package:flutter_chat_socket/src/widgets/blue_buttom.dart';
import 'package:flutter_chat_socket/src/widgets/labels.dart';
import 'package:flutter_chat_socket/src/widgets/logo.dart';
import 'package:flutter_chat_socket/src/widgets/textfiel_custom.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.95,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(
                  title: 'Registrarte Ahora!',
                ),
                _FormState(),
                Labels(
                  title: 'Ya tengo una Cuenta',
                  rute: "login",
                  buttomTitle: 'Iniciar Sessión',
                ),
                Text("Terminos y Condiciones de uso"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormState extends StatefulWidget {
  @override
  __FormStateState createState() => __FormStateState();
}

class __FormStateState extends State<_FormState> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFieldCustom(
            icon: Icons.person,
            hintText: "Nombres",
            inputType: TextInputType.text,
            textController: nameCtrl,
          ),
          TextFieldCustom(
            icon: Icons.email,
            hintText: "Correo",
            inputType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          TextFieldCustom(
            icon: Icons.vpn_key,
            hintText: "Contraseña",
            textController: passCtrl,
            obscureText: true,
          ),
          SizedBox(height: 10),
          BlueButtom(
            titleText: "Ingresar",
            onPressed: () {
              print(emailCtrl.text);
              print(passCtrl.text);
            },
          ),
        ],
      ),
    );
  }
}
