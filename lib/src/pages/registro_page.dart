import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/src/services/auth_service.dart';
import 'package:chatapp/src/widgets/button_blue.dart';
import 'package:chatapp/src/widgets/labels_login.dart';
import 'package:chatapp/src/widgets/logo_login.dart';
import 'package:chatapp/src/widgets/custom_input.dart';
import 'package:chatapp/src/helpers/mostrar_alerta.dart';
import 'package:chatapp/src/services/socket_service.dart';

class RegisterPage extends StatelessWidget {
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
              Logo(titulo: 'Registro'),
              _Form(),
              Labels(
                  name: 'Ya tienes cuenta',
                  descripcion: 'Ingresa con la misma ',
                  ruta: 'login'),
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
  final nameCtrl = TextEditingController();
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
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
            isPassword: false,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Corre Electrónico',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
            isPassword: false,
          ),
          CustomInput(
            icon: Icons.lock,
            placeholder: 'Corre Electrónico',
            keyboardType: TextInputType.text,
            textController: passwordCtrl,
            isPassword: true,
          ),
          ButtonBlue(
            text: 'Ingrese',
            onPressed: authService.autenticando
                ? null
                : () async {
                    print(emailCtrl.text);
                    print(passwordCtrl.text);
                    FocusScope.of(context).unfocus();
                    final registroOk = await authService.registro(
                        nameCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        passwordCtrl.text.trim());
                    if (registroOk == true) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostraralerta(context, 'Registro Incorrecto', registroOk);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
