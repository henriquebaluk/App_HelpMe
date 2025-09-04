
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? currentUser;

  bool get isLogged => currentUser != null;

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    final name = p.getString('user_name');
    final email = p.getString('user_email');
    if (name != null && email != null) {
      currentUser = UserModel(name: name, email: email);
      notifyListeners();
    }
  }

  Future<void> signup(String name, String email, String password) async {
    final p = await SharedPreferences.getInstance();
    await p.setString('signup_name', name);
    await p.setString('signup_email', email);
    await p.setString('signup_password', password);
  }

  Future<bool> login(String email, String password) async {
    final p = await SharedPreferences.getInstance();
    final se = p.getString('signup_email');
    final sp = p.getString('signup_password');
    final sn = p.getString('signup_name') ?? 'Usuário';

    if (se != null && sp != null && email == se && password == sp) {
      await p.setString('user_name', sn);
      await p.setString('user_email', se);
      currentUser = UserModel(name: sn, email: se);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final p = await SharedPreferences.getInstance();
    await p.remove('user_name');
    await p.remove('user_email');
    currentUser = null;
    notifyListeners();
  }
}
