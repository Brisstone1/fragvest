import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences prefs;

  LocalStorage(this.prefs);

  Future<void> saveToken(String token) async {
    return prefs.setString('token', token);
  }

  String getToken() {
    return prefs.getString('token');
  }

  Future<void> saveFirstName(String name) async {
    return prefs.setString('firstName', name);
  }

  String getFirstName() {
    return prefs.getString('firstName');
  }

  Future<void> saveLastName(String name) async {
    return prefs.setString('lastName', name);
  }

  String getLastName() {
    return prefs.getString('lastName');
  }

  Future<void> saveEmail(String email) async {
    return prefs.setString('email', email);
  }

  String getEmail() {
    return prefs.getString('email');
  }

  Future<void> savePhone(String phone) async {
    return prefs.setString('phone', phone);
  }

  String getPhone() {
    return prefs.getString('phone');
  }
}
