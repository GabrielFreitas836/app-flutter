import 'package:app_flutter/src/models/user_model.dart';
import 'package:app_flutter/src/services/user_service.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  final List<UserModel> _users = [];
  List<UserModel> get users => _users;
  Map<String, dynamic>? data;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      data = await _userService.login(
        UserModel(
          name: '',
          email: email,
          password: password,
        ),
      );
      
      notifyListeners();
      return data!;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      data = await _userService.register(
        UserModel(
          name: name,
          email: email,
          password: password,
        ),
      );
      
      _users.add(UserModel(
        name: name,
        email: email,
        password: password,
      ));
      
      notifyListeners();
      return data!;
    } catch (e) {
      rethrow;
    }
  }

}