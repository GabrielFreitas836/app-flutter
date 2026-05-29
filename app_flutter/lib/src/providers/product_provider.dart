import 'package:app_flutter/src/models/product_model_a.dart';
import 'package:app_flutter/src/models/product_model_b.dart';
import 'package:app_flutter/src/services/product_service_a.dart';
import 'package:app_flutter/src/services/product_service_b.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {
  final ProductServiceA _productService = ProductServiceA();
  final ProductServiceB _productServiceB = ProductServiceB();

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

  Future<Map<String, dynamic>> addProduct(ProductModelB product) async {
    try {
      data = await _productServiceB.newProduct(product);

      await fetchProducts();
      return data!;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createProduct(ProductModelB product) async {
    return addProduct(product);
  }

  Future<Map<String, dynamic>> deleteProduct(int productId) async {
    try {
      data = await _productServiceB.deleteProduct(productId);

      await fetchProducts();
      return data!;
    } catch (e) {
      rethrow;
    }
  }
}
