import 'package:shared_preferences/shared_preferences.dart';

class AuthToken {

  void setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');
    return token;
  }

  void removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');
  }
}