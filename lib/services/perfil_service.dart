import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/usuario.dart';

class PerfilService {
  final String baseUrl = 'http://localhost:8080';
  //final String baseUrl = 'http://52.15.61.91:8080';

  // Métodos existentes omitidos...

  Future<Usuario> getUsuario(String token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/usuarios/detalhar'), // Substitua pelo endpoint correto para obter o perfil do usuário
        headers: headers,
      );
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        if (userData != null && userData.isNotEmpty) {
          return Usuario.fromJson(userData);
        } else {
          throw Exception('Erro: Dados do usuário vazios');
        }
      } else {
        throw Exception('Erro ao carregar os dados do usuário: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erro ao buscar perfil do usuário: $error');
    }
  }

  Future<Usuario> editarUsuario(String token, Usuario editarUsuarioDTO) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final requestBody = json.encode(editarUsuarioDTO.toJson());

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/usuarios/editar'), // Substitua pelo endpoint correto para editar o usuário
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        return Usuario.fromJson(userData);
      } else {
        throw Exception('Erro ao editar o usuário: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erro ao editar o usuário: $error');
    }
  }
}
