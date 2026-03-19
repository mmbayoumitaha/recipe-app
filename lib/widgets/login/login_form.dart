import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/login/login_cubit.dart';
import '../../cubit/login/login_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleFormSubmission() {
    if (!_formKey.currentState!.validate()) return;

    context.read<LoginCubit>().submit(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state.status == LoginStatus.loading;
        
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildFormTitle(state.isLogin),
                const SizedBox(height: 20),
                _buildEmailInput(scheme),
                const SizedBox(height: 16),
                _buildPasswordInput(scheme, state),
                const SizedBox(height: 24),
                _buildSubmitButton(scheme, isLoading, state.isLogin),
                const SizedBox(height: 16),
                _buildToggleModeSection(scheme, state.isLogin),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormTitle(bool isLoginMode) {
    return Text(
      isLoginMode ? 'Welcome Back!' : 'Create Account',
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildEmailInput(ColorScheme scheme) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: const Icon(Icons.email_outlined),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
      validator: (emailValue) {
        if (emailValue == null || emailValue.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordInput(ColorScheme scheme, LoginState state) {
    return TextFormField(
      controller: _passwordController,
      obscureText: state.obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: IconButton(
          icon: Icon(
            state.obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            context.read<LoginCubit>().togglePasswordVisibility();
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
      validator: (passwordValue) {
        if (passwordValue == null || passwordValue.length < 4) {
          return 'Password must be at least 4 characters';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton(ColorScheme scheme, bool isLoading, bool isLoginMode) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : _handleFormSubmission,
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Text(
                isLoginMode ? 'Log In' : 'Sign Up',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildToggleModeSection(ColorScheme scheme, bool isLoginMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLoginMode ? "Don't have an account? " : 'Already have an account? ',
          style: const TextStyle(color: Colors.grey),
        ),
        GestureDetector(
          onTap: () {
            context.read<LoginCubit>().toggleLoginMode();
          },
          child: Text(
            isLoginMode ? 'Sign Up' : 'Log In',
            style: TextStyle(
              color: scheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
