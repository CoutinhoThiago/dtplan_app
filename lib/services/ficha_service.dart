import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://localhost:8080';
  //final String baseUrl = 'http://52.15.61.91:8080';

  Future<http.Response> cadastrarFicha(Map<String, dynamic> dados) async {
    return http.post(
      Uri.parse('$baseUrl/usuarios/cadastrar'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dados),
    );
  }

  Future<http.Response> getTodasAsFichas(String token) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/fichas/detalhar'), // Substitua pelo endpoint correto para obter o perfil do usuário
        headers: headers,
      );

      return response;
    } catch (error) {
      throw Exception('Erro ao buscar Fichas: $error');
    }
  }

  Future<http.Response> getFichasTreino(String token, String treinoId) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/fichas/$treinoId'), // Substitua pelo endpoint correto para obter o perfil do usuário
        headers: headers,
      );

      return response;
    } catch (error) {
      throw Exception('Erro ao buscar fichas do treino $treinoId: $error');
    }
  }
  
  Future<http.Response> getTreino(String token, String fichaId) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/fichas/detalhar/$fichaId'), // Substitua pelo endpoint correto para obter o perfil do usuário
        headers: headers,
      );

      return response;
    } catch (error) {
      throw Exception('Erro ao detalhar ficha $fichaId: $error');
    }
  }
}
