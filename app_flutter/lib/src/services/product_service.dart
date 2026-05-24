import 'dart:convert';
import 'package:app_flutter/src/models/product_model.dart';
import 'package:app_flutter/src/services/auth_token.dart';
import 'package:http/http.dart' as http;

class ProductService {

  final String baseUrl = 'http://192.168.0.4:4040';
  final AuthToken authToken = AuthToken();

  Future<List<ProductModel>> getAllProducts() async {
    // final token = await authToken.getToken();
    final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZFVzdWFyaW8iOjEsImlhdCI6MTc3OTY1MjUwMywiZXhwIjoxNzgwMjU3MzAzfQ.d62mCMEZcfRoTjHE5A137pMO2C4S7dY3aR4oTu1fRzg';

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
        return (data['values'] as List).map((product) => ProductModel.fromJson(product)).toList();
      }
      else if (response.statusCode == 401) {
        authToken.removeToken();
        throw Exception('Token inválido ou expirado');
      }
      else {
        throw Exception('Erro ao buscar produtos');
      }
    } catch (e) {
      rethrow;
    }
   
  }
}