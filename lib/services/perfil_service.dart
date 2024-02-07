import 'package:http/http.dart' as http;
import 'dart:convert';

class PerfilService {
  final String baseUrl = 'http://10.0.2.2:8080'; // Substitua pelo URL correto
  //final String baseUrl = 'http://52.15.61.91:8080';

  Future<http.Response> cadastrarUsuario(Map<String, dynamic> dados) async {
    return http.post(
      Uri.parse('$baseUrl/usuarios/cadastrar'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dados),
    );
  }

  Future<Map<String, dynamic>> getUsuario(String token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/usuarios/detalhar'), // Substitua pelo endpoint correto para obter o perfil do usuário
        headers: headers,
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ao carregar os dados do usuário: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erro ao buscar perfil do usuário: $error');
    }
  }
}
