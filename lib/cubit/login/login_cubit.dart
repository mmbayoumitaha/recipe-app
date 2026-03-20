import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import '../../models/app_user.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState());

  void toggleMode() {
    emit(state.copyWith(
      isLogin: !state.isLogin,
      status: LoginStatus.initial,
      clearErrorMessage: true,
    ));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> submit({required String email, required String password}) async {
    final normalizedEmail = email.trim().toLowerCase();
    emit(state.copyWith(status: LoginStatus.loading, clearErrorMessage: true));

    if (state.isLogin) {
      return _processLogin(normalizedEmail, password);
    }
    return _processRegistration(normalizedEmail, password);
  }

  Future<void> _processRegistration(String email, String password) async {
    final existingUser = await _authRepository.getUser(email);
    if (existingUser != null) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Account already exists',
      ));
      return;
    }

    final newUser = AppUser(email: email, password: password);
    await _authRepository.registerUser(newUser);
    _authRepository.login(email);

    emit(state.copyWith(status: LoginStatus.success));
  }

  Future<void> _processLogin(String email, String password) async {
    final user = await _authRepository.getUser(email);
    
    if (user == null) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Account not found',
      ));
      return;
    }

    if (user.password != password) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Incorrect password',
      ));
      return;
    }

    _authRepository.login(email);
    emit(state.copyWith(status: LoginStatus.success));
  }

  void logout() {
    _authRepository.logout();
    emit(const LoginState(status: LoginStatus.initial));
  }
}
