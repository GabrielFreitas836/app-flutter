import 'dart:convert';
import 'package:app_flutter/src/models/product_model.dart';
import 'package:app_flutter/src/services/auth_token.dart';
import 'package:http/http.dart' as http;

class ProductService {

  final String baseUrl = 'http://192.168.0.4:4040';
  final AuthToken authToken = AuthToken();

  Future<List<ProductModel>> getAllProducts() async {
    final token = await authToken.getToken();

    try {
       final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return List<ProductModel>.from((data as List).map((item) => ProductModel.fromJson(item)));
      }
      else if (response.statusCode == 401) {
        authToken.removeToken();
        throw Exception(data['message'] ?? 'Token inválido ou expirado');
      }
      else {
        throw Exception(data['message'] ?? 'Erro ao buscar produtos');
      }
    } catch (e) {
      rethrow;
    }
   
  }
}