class ProductModelB {
  final String description;
  final double unitValue;
  final String unitType;
  final int categoryId;

  ProductModelB({
    required this.description,
    required this.unitValue,
    required this.unitType,
    required this.categoryId,
  });

  factory ProductModelB.fromJson(Map<String, dynamic> json) {
    return ProductModelB(
      description: json['produto'],
      unitValue: double.parse(json['valor_unitario'].toString()),
      unitType: json['tipo_unidade'],
      categoryId: int.parse(json['categoria_id'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descricao': description,
      'valor_unitario': unitValue,
      'tipo_unidade': unitType,
      'categoria_id': categoryId,
    };
  }
}
