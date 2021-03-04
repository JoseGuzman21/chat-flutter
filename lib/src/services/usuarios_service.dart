import 'package:http/http.dart' as http;
import 'package:chatapp/src/models/usuarios_response.dart';
import 'package:chatapp/src/global/environment.dart';
import 'package:chatapp/src/services/auth_service.dart';
import 'package:chatapp/src/models/usuarios.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get('${Environment.apiUrl}/usuarios', headers: {
        'Content-type': 'application/json',
        'Authorization': await AuthService.getToken()
      });
      final usuariosReponse = usuariosResponseFromJson(resp.body);
      return usuariosReponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
