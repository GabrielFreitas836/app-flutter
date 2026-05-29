class ProductModelA {
  final int productId;
  final String description;
  final double unitValue;
  final String unitType;
  final String category;

  ProductModelA({
    required this.productId,
    required this.description,
    required this.unitValue,
    required this.unitType,
    required this.category,
  });

  factory ProductModelA.fromJson(Map<String, dynamic> json) {
    return ProductModelA(
      productId: int.parse(
        (json['productId'] ?? json['idProduto'] ?? json['idproduto'])
            .toString(),
      ),
      description: json['produto'],
      unitValue: double.parse(json['valor_unitario'].toString()),
      unitType: json['tipo_unidade'],
      category: json['categoria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'produto': description,
      'valor_unitario': unitValue,
      'tipo_unidade': unitType,
      'categoria': category,
    };
  }
}
