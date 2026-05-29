import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthToken {
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');
    return token;
  }

  Future<int> getUserId() async {
    final token = await getToken();

    if (token == null) {
      throw Exception('Token nao encontrado. Faca login novamente.');
    }

    final tokenParts = token.split('.');

    if (tokenParts.length != 3) {
      throw Exception('Token invalido. Faca login novamente.');
    }

    final payload = utf8.decode(
      base64Url.decode(base64Url.normalize(tokenParts[1])),
    );
    final Map<String, dynamic> data = jsonDecode(payload);

    return int.parse(data['idUsuario'].toString());
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');
  }
}
