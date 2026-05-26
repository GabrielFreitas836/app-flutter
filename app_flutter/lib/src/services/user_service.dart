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
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode((user.toJson()))
      );

      if (response.statusCode == 200) {

        final Map<String, dynamic> data = jsonDecode(response.body);

        authToken.setToken(data['token'] as String);
        return data;
      }
      else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        throw Exception(data['message'] as String? ?? 'Falha ao realizar login');
      }
    } catch (e) {
      rethrow;
    }
  }
}