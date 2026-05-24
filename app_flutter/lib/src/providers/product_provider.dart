import 'package:app_flutter/src/models/product_model.dart';
import 'package:app_flutter/src/services/product_service.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> fetchProducts() async {
    try {
      _products = await _productService.getAllProducts();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}