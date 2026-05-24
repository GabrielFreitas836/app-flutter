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
      unitValue: double.parse(json['valor_unitario'].toString()),
      unitType: json['tipo_unidade'],
      category: json['categoria']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'produto': description,
      'valor_unitario': unitValue,
      'tipo_unidade': unitType,
      'categoria': category
    };
  }
}