import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  AuthProvider() {
    _loadToken();
  }

  // Método para carregar o token de SharedPreferences
  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('authToken');
    notifyListeners();
  }

  // Getter para acessar o token
  String? get token => _token;

  // Verifica se o usuário está logado
  bool get isAuthenticated => _token != null;

  // Método para fazer logout
  Future<void> logout() async {
    _token = null;

    // Remove o token de SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');

    notifyListeners();
  }
}
