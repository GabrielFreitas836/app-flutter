class ProductModel {
  final String description;
  final double unitValue;
  final String unitType;
  final String category;

  ProductModel({
    required this.description, 
    required this.unitValue, 
    required this.unitType,
    required this.category
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      description: json['produto'],
      unitValue: json['valor_unitario'],
      unitType: json['tipo_unidade'],
      category: json['categoria']
    );
  }
}