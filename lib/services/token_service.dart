import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const _tokenKey = 'userToken';

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<bool> isTokenValid() async {
    final String? token = await getToken();
    if (token == null) {
      return false;
    }

    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return false;
      }

      final payload = _normalizeBase64(parts[1]);
      final decoded = base64Decode(payload);
      final Map<String, dynamic> data = json.decode(utf8.decode(decoded));

      final expiration = data['exp'] * 1000;
      final currentDate = DateTime.now().millisecondsSinceEpoch;

      return currentDate < expiration;
    } catch (e) {
      return false;
    }
  }

  String _normalizeBase64(String base64) {
    String normalized = base64.replaceAll('-', '+').replaceAll('_', '/');
    return normalized.padRight(normalized.length + (4 - normalized.length % 4) % 4, '=');
  }
}
