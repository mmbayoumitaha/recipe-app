import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../models/app_user.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Box<AppUser> get _usersBox => Hive.box<AppUser>('users');
  Box get _authBox => Hive.box('auth');

  void toggleLoginMode() {
    emit(
      state.copyWith(
        isLogin: !state.isLogin,
        status: LoginStatus.initial,
        clearErrorMessage: true,
      ),
    );
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> submit({required String email, required String password}) async {
    final normalizedEmail = email.trim().toLowerCase();
    emit(state.copyWith(status: LoginStatus.loading, clearErrorMessage: true));

    if (state.isLogin) {
      await _login(email: normalizedEmail, password: password);
      return;
    }

    await _signUp(email: normalizedEmail, password: password);
  }

  Future<void> _signUp({
    required String email,
    required String password,
  }) async {
    final existingUser = _usersBox.get(email);
    if (existingUser != null) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Account already exists',
        ),
      );
      return;
    }

    final user = AppUser(email: email, password: password);
    await _usersBox.put(email, user);
    await _authBox.put('loggedIn', true);
    await _authBox.put('email', email);

    emit(state.copyWith(status: LoginStatus.success));
  }

  Future<void> _login({required String email, required String password}) async {
    final user = _usersBox.get(email);
    if (user == null) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Account not found',
        ),
      );
      return;
    }

    if (user.password != password) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Incorrect password',
        ),
      );
      return;
    }

    await _authBox.put('loggedIn', true);
    await _authBox.put('email', email);
    emit(state.copyWith(status: LoginStatus.success));
  }

  Future<void> logout() async {
    await _authBox.put('loggedIn', false);
    await _authBox.delete('email');
    emit(state.copyWith(status: LoginStatus.initial, clearErrorMessage: true));
  }
}
