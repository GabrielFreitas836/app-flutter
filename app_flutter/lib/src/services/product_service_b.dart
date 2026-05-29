import 'dart:convert';
import 'package:app_flutter/src/models/product_model_b.dart';
import 'package:app_flutter/src/services/auth_token.dart';
import 'package:http/http.dart' as http;

class ProductServiceB {
  final String baseUrl = 'http://192.168.0.4:4040';
  final AuthToken authToken = AuthToken();

  Future<Map<String, dynamic>> newProduct(ProductModelB product) async {
    final token = await authToken.getToken();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/products/newProduct'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        await authToken.removeToken();
        throw Exception(
          data['message'] ??
              'Token inválido ou expirado. Faça login novamente.',
        );
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        throw Exception(data['message'] ?? 'Erro ao criar produto');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteProduct(int productId) async {
    final token = await authToken.getToken();

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/products/$productId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        await authToken.removeToken();
        throw Exception(
          data['message'] ??
              'Token invalido ou expirado. Faca login novamente.',
        );
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        throw Exception(data['message'] ?? 'Erro ao excluir produto');
      }
    } catch (e) {
      rethrow;
    }
  }
}
