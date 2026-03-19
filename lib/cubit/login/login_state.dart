import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final bool isLogin;
  final bool obscurePassword;
  final LoginStatus status;
  final String? errorMessage;

  const LoginState({
    this.isLogin = true,
    this.obscurePassword = true,
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isLogin,
    bool? obscurePassword,
    LoginStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return LoginState(
      isLogin: isLogin ?? this.isLogin,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      status: status ?? this.status,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [isLogin, obscurePassword, status, errorMessage];
}
