import 'package:chatapp/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/src/services/auth_service.dart';
import 'package:chatapp/src/widgets/button_blue.dart';
import 'package:chatapp/src/widgets/labels_login.dart';
import 'package:chatapp/src/widgets/logo_login.dart';
import 'package:chatapp/src/widgets/custom_input.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/src/helpers/mostrar_alerta.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Logo(titulo: 'Messenger'),
              _Form(),
              Labels(
                  name: 'No tienes cuenta?',
                  descripcion: 'Crea una ahora!',
                  ruta: 'register'),
              Text(
                'Términos y condiciones de uso',
                style: TextStyle(fontWeight: FontWeight.w200),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Corre Electrónico',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
            isPassword: false,
          ),
          CustomInput(
            icon: Icons.lock,
            placeholder: 'Password',
            keyboardType: TextInputType.emailAddress,
            textController: passwordCtrl,
            isPassword: true,
          ),
          ButtonBlue(
            text: 'Ingrese',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passwordCtrl.text.trim());
                    if (loginOk) {
                      // conectar a nuestro socket server
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostraralerta(context, 'Login Incorrecto',
                          'Revise sus credenciales nuevamente');
                    }
                  },
          ),
        ],
      ),
    );
  }
}
