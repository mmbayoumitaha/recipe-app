import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/login/login_cubit.dart';
import '../../cubit/login/login_state.dart';
import 'form_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailCtl = TextEditingController();
  final _passwordCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailCtl.dispose();
    _passwordCtl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<LoginCubit>().submit(email: _emailCtl.text, password: _passwordCtl.text);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final loading = state.status == LoginStatus.loading;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildHeader(state.isLogin, scheme),
                const SizedBox(height: 20),
                _buildInputs(scheme, state),
                const SizedBox(height: 24),
                _buildAction(scheme, loading, state.isLogin),
                const SizedBox(height: 16),
                _buildFooter(scheme, state.isLogin),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isLogin, ColorScheme scheme) {
    return Text(
      isLogin ? 'Welcome Back!' : 'Create Account',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: scheme.onSurface),
    );
  }

  Widget _buildInputs(ColorScheme scheme, LoginState state) {
    return Column(
      children: [
        FormTextField(
            controller: _emailCtl,
            label: 'Email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (v) => v == null || v.isEmpty ? 'Email is required' : null),
        const SizedBox(height: 16),
        FormTextField(
          controller: _passwordCtl,
          label: 'Password',
          prefixIcon: Icons.lock_outlined,
          obscureText: state.obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              state.obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: scheme.onSurface.withValues(alpha: 0.6),
            ),
            onPressed: () => context.read<LoginCubit>().togglePasswordVisibility(),
          ),
          validator: (v) => v == null || v.length < 4 ? 'Password too short' : null,
        ),
      ],
    );
  }

  Widget _buildAction(ColorScheme scheme, bool loading, bool isLogin) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: loading ? null : _handleSubmit,
        child: loading
            ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
            : Text(isLogin ? 'Log In' : 'Sign Up', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      ),
    );
  }

  Widget _buildFooter(ColorScheme scheme, bool isLogin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? "Don't have an account? " : 'Already have an account? ',
          style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.6)),
        ),
        GestureDetector(
          onTap: () => context.read<LoginCubit>().toggleMode(),
          child: Text(
            isLogin ? 'Sign Up' : 'Log In',
            style: TextStyle(color: scheme.primary, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
