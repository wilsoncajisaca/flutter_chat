import 'package:flutter/material.dart';
import 'package:flutter_chat_socket/src/helpers/show_alert.dart';
import 'package:flutter_chat_socket/src/services/auth_services.dart';
import 'package:flutter_chat_socket/src/services/socket_service.dart';
import 'package:flutter_chat_socket/src/widgets/blue_buttom.dart';
import 'package:flutter_chat_socket/src/widgets/labels.dart';
import 'package:flutter_chat_socket/src/widgets/logo.dart';
import 'package:flutter_chat_socket/src/widgets/textfiel_custom.dart';
import 'package:provider/provider.dart';

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
    final authServices = Provider.of<AuthServices>(context);
    final socketService = Provider.of<SocketService>(context);
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
            onPressed: authServices.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authServices.register(
                        nameCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        passCtrl.text.trim());
                    if (loginOk) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      showAlert(context, 'Registro Incorrecto',
                          authServices.messageError);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
