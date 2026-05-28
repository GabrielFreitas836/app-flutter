class UserModel {
  final String name;
  final String email;
  final String password;

  UserModel({
    required this.name,
    required this.email, 
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['nome'],
      email: json['email'],
      password: json['senha'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': name,
      'email': email,
      'senha': password,
    };
  }
}