import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';
import '../widgets/login/login_header.dart';
import '../widgets/login/login_form.dart';
import '../cubit/recipe/recipe_cubit.dart';
import 'main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _handleAuthenticationState(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.failure && state.errorMessage != null) {
      _showErrorSnackBar(context, state.errorMessage!);
    } else if (state.status == LoginStatus.success) {
      context.read<RecipeCubit>().refresh();
      _navigateToHomeScreen(context);
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.primary, colorScheme.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: BlocListener<LoginCubit, LoginState>(
            listener: _handleAuthenticationState,
            child: const Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginHeader(),
                    SizedBox(height: 40),
                    LoginForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
