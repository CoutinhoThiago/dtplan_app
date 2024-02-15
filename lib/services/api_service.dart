import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://localhost:8080';
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

  Future<String> login(String login, String senha) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'login': login, 'senha': senha}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        String token = data['token'];
        return token;
      } else {
        throw Exception('Erro de login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  Future<void> handleCadastro(String login, String senha, String role, String nome, String cpf, BuildContext context) async {
    final dadosUsuario = {
      "login": login,
      "senha": senha,
      "role": role.toUpperCase(),
      "nome": nome,
      "cpf": cpf,
    };

    try {
      final response = await cadastrarUsuario(dadosUsuario);
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {

        } catch (error) {
          print('Erro de conexão: $error');
        }
      } else {
        print('Falha no cadastro. Código de status: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro de conexão: $error');
    }
  }

  Future<http.Response> getPerfilUsuario(String token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/usuarios/detalhar'), // Substitua pelo endpoint correto para obter o perfil do usuário
        headers: headers,
      );

      return response;
    } catch (error) {
      throw Exception('Erro ao buscar perfil do usuário: $error');
    }
  }

  Future<http.Response> getTreinos(String token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/treinos/listar'), // Substitua pelo endpoint correto para obter o perfil do usuário
        headers: headers,
      );

      return response;
    } catch (error) {
      throw Exception('Erro ao buscar treinos do usuário: $error');
    }
  }
  Future<http.Response> getTreino(String token, String id) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/treinos/detalhar/$id'), // Substitua pelo endpoint correto para obter o perfil do usuário
        headers: headers,
      );

      return response;
    } catch (error) {
      throw Exception('Erro ao buscar treinos do usuário: $error');
    }
  }

  Future<http.Response> getExercicio(String token, String id) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/exercicios/$id'), // Substitua pelo endpoint correto para obter o perfil do usuário
        headers: headers,
      );

      return response;
    } catch (error) {
      throw Exception('Erro ao buscar treinos do usuário: $error');
    }
  }
}
