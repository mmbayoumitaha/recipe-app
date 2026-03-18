import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLogin;
  final bool obscurePassword;

  const LoginState({
    this.isLogin = true,
    this.obscurePassword = true,
  });

  LoginState copyWith({
    bool? isLogin,
    bool? obscurePassword,
  }) {
    return LoginState(
      isLogin: isLogin ?? this.isLogin,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object?> get props => [isLogin, obscurePassword];
}
