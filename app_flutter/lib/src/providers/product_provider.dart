import 'package:app_flutter/src/models/product_model_a.dart';
import 'package:app_flutter/src/services/product_service.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();

  Map<String, dynamic>? data;
  List<ProductModelA> _products = [];
  List<ProductModelA> get products => _products;

  Future<void> fetchProducts() async {
    try {
      _products = await _productService.getAllProducts();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addProduct(ProductModelA product) async {
    try {
      data = await _productService.newProduct(product);
      await fetchProducts();
      return data!;
    } catch (e) {
      rethrow;
    }
  }
}