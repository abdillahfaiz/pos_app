import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  Future init() async {
    await Hive.initFlutter();
    Hive.openBox('user');
  }

  var userBox = Hive.box('user');

  void saveToken(String token) {
    userBox.put('token', token);
  }

  String? getToken() {
    return userBox.get('token');
  }

  void removeToken() {
    userBox.delete('token');
  }
}
