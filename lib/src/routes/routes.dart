import 'package:flutter/material.dart';
import 'package:chatapp/src/pages/chat_page.dart';
import 'package:chatapp/src/pages/loading_page.dart';
import 'package:chatapp/src/pages/login_page.dart';
import 'package:chatapp/src/pages/registro_page.dart';
import 'package:chatapp/src/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
  'login': (_) => LoginPage(),
};
