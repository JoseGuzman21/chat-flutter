import 'package:chatapp/src/global/environment.dart';
import 'package:chatapp/src/models/mensajes_response.dart';
import 'package:chatapp/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/src/models/usuarios.dart';

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioId) async {
    final resp =
        await http.get('${Environment.apiUrl}/mensajes/$usuarioId', headers: {
      'Content-Type': 'application/json',
      'Authorization': await AuthService.getToken()
    });

    final mensajesResp = mensajesResponseFromJson(resp.body);
    return mensajesResp.mensajes;
  }
}
