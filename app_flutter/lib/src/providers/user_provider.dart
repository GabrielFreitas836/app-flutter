import 'package:app_flutter/src/models/user_model.dart';
import 'package:app_flutter/src/services/user_service.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  late final Map<String, dynamic> data;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      data = await _userService.login(
        UserModel(
          id: '',
          name: '',
          email: email,
          password: password,
        ),
      );
      
      notifyListeners();
      return data;
    } catch (e) {
      rethrow;
    }
  }

}