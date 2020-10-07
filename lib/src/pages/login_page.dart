import 'package:flutter/material.dart';
import 'package:flutter_chat_socket/src/helpers/show_alert.dart';
import 'package:flutter_chat_socket/src/services/auth_services.dart';
import 'package:flutter_chat_socket/src/services/socket_service.dart';
import 'package:flutter_chat_socket/src/widgets/blue_buttom.dart';
import 'package:flutter_chat_socket/src/widgets/labels.dart';
import 'package:flutter_chat_socket/src/widgets/logo.dart';
import 'package:flutter_chat_socket/src/widgets/textfiel_custom.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  title: 'Iniciar Session',
                ),
                _FormState(),
                Labels(
                  title: '¿No tienes una Cuenta?',
                  rute: "register",
                  buttomTitle: 'Crea Una',
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
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final socketServices = Provider.of<SocketService>(context);
    return Container(
      child: Column(
        children: [
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
            onPressed: authServices.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authServices.login(
                      emailCtrl.text.trim(),
                      passCtrl.text.trim(),
                    );

                    if (loginOk) {
                      socketServices.connect();
                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      showAlert(context, 'Login Incorrecto',
                          'Revise sus credenciales');
                    }
                  },
          ),
        ],
      ),
    );
  }
}
