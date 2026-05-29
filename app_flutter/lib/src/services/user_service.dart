import 'dart:convert';
import 'package:app_flutter/src/models/user_model.dart';
import 'package:app_flutter/src/services/auth_token.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'http://192.168.0.4:4040';
  final AuthToken authToken = AuthToken();

  Future<Map<String, dynamic>> login(UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode((user.toJson())),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        await authToken.setToken(data['token'] as String);
        return data;
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        throw Exception(
          data['message'] as String? ?? 'Falha ao realizar login',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getOrcamentoByUserId() async {
    final token = await authToken.getToken();
    final userId = await authToken.getUserId();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orcamento/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else if (response.statusCode == 401) {
        await authToken.removeToken();
        throw Exception(
          data['message'] ??
              'Token invalido ou expirado. Faca login novamente.',
        );
      } else {
        throw Exception(data['message'] ?? 'Erro ao buscar orcamento');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateOrcamentoByUserId(String orcamento) async {
    final token = await authToken.getToken();
    final userId = await authToken.getUserId();

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/orcamento/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'orcamento': orcamento}),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else if (response.statusCode == 401) {
        await authToken.removeToken();
        throw Exception(
          data['message'] ??
              'Token inválido ou expirado. Faça login novamente.',
        );
      } else {
        throw Exception(data['message'] ?? 'Erro ao atualizar orcamento');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register(UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/newUser'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode((user.toJson())),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        throw Exception(
          data['message'] as String? ?? 'Falha ao realizar cadastro',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
