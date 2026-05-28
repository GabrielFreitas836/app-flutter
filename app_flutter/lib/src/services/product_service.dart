import 'dart:convert';
import 'package:app_flutter/src/models/product_model_a.dart';
import 'package:app_flutter/src/services/auth_token.dart';
import 'package:http/http.dart' as http;

class ProductService {

  final String baseUrl = 'http://192.168.0.4:4040';
  final AuthToken authToken = AuthToken();

  Future<List<ProductModelA>> getAllProducts() async {
    final token = await authToken.getToken();

    try {
       final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }
      );

      if (response.statusCode == 200) {

        final Map<String, dynamic> data = jsonDecode(response.body);
        return (data['values'] as List).map((product) => ProductModelA.fromJson(product)).toList();
      }
      else if (response.statusCode == 401) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        authToken.removeToken();
        throw Exception(data['message'] ?? 'Token inválido ou expirado. Faça login novamente.');
      }
      else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        throw Exception(data['message'] ?? 'Erro ao buscar produtos');
      }
    } catch (e) {
      rethrow;
    }
   
  }

  Future<Map<String, dynamic>> newProduct(ProductModelA product) async {
    final token = await authToken.getToken();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/products/newProduct'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(product.toJson())
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
      else if (response.statusCode == 401) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        authToken.removeToken();
        throw Exception(data['message'] ?? 'Token inválido ou expirado. Faça login novamente.');
      }
      else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        throw Exception(data['message'] ?? 'Erro ao criar produto');
      }
    } catch (e) {
      rethrow;
    }
  }
}