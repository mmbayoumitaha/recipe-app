import 'package:hive_flutter/hive_flutter.dart';
import '../../models/app_user.dart';

class AuthRepository {
  final Box<AppUser> _userBox = Hive.box<AppUser>('users');
  final Box _authBox = Hive.box('auth');

  Future<AppUser?> getUser(String email) async {
    return _userBox.get(email);
  }

  Future<void> registerUser(AppUser user) async {
    await _userBox.put(user.email, user);
  }

  void login(String email) {
    _authBox.put('loggedIn', true);
    _authBox.put('email', email);
  }

  void logout() {
    _authBox.put('loggedIn', false);
    _authBox.delete('email');
  }

  bool isLoggedIn() {
    return _authBox.get('loggedIn', defaultValue: false);
  }

  String? getCurrentUserEmail() {
    return _authBox.get('email');
  }
}
