import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  static const _usersKey = 'helpme_users';
  static const _currentUserKey = 'helpme_current_user';
  static const _historyKey = 'helpme_history';

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString(_currentUserKey);
    if (text == null) return null;
    return jsonDecode(text) as Map<String, dynamic>;
  }

  Future<void> setCurrentUser(Map<String, dynamic>? user) async {
    final prefs = await SharedPreferences.getInstance();
    if (user == null) {
      await prefs.remove(_currentUserKey);
    } else {
      await prefs.setString(_currentUserKey, jsonEncode(user));
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString(_usersKey);
    if (text == null) return [];
    return (jsonDecode(text) as List).cast<Map<String, dynamic>>();
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getUsers();
    final email = (user['email'] ?? '').toString().toLowerCase();
    users.removeWhere((u) => (u['email'] ?? '').toString().toLowerCase() == email);
    users.add(user);
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  Future<Map<String, dynamic>?> findUser(String email) async {
    final users = await getUsers();
    final e = email.toLowerCase().trim();
    try {
      return users.firstWhere((u) => (u['email'] ?? '').toString().toLowerCase() == e);
    } catch (_) {
      return null;
    }
  }

  // Histórico (ajudas concluídas + avaliação)
  Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString(_historyKey);
    if (text == null) return [];
    return (jsonDecode(text) as List).cast<Map<String, dynamic>>();
  }

  Future<void> addHistoryItem(Map<String, dynamic> item) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getHistory();
    list.add(item);
    await prefs.setString(_historyKey, jsonEncode(list));
  }
}
