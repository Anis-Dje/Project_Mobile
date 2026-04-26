import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';

/// Unified login screen for all three roles. Authenticates against the mock
/// `AuthService` and redirects to the role-specific dashboard.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _submitting = false;
  String? _errorText;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _submitting = true;
      _errorText = null;
    });

    final AuthResult result = await AuthService.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (result is AuthFailure) {
      setState(() {
        _submitting = false;
        _errorText = result.message;
      });
      return;
    }

    final AuthSuccess success = result as AuthSuccess;
    final User user = success.user;

    if (user.role == AppStrings.roleIntern && !user.approved) {
      Navigator.of(context).pushReplacementNamed(
        AppRoutes.pending,
        arguments: user,
      );
      return;
    }

    Navigator.of(context).pushReplacementNamed(
      AppRoutes.dashboardForRole(user.role),
      arguments: user,
    );
  }

  String? _validateEmail(String? value) {
    final String email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email is required';
    final RegExp emailRegex = RegExp(r'^[\w.\-]+@[\w\-]+\.[\w.\-]+$');
    if (!emailRegex.hasMatch(email)) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Minimum 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.business_center_outlined,
                          color: AppColors.primary,
                          size: 38,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppStrings.appName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColors.textOnPrimary),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      AppStrings.appTagline,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textOnPrimary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.university,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textOnPrimary.withValues(alpha: 0.65),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Sign in',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Use your enterprise credentials',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              validator: _validateEmail,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            const SizedBox(height: 14),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              textInputAction: TextInputAction.done,
                              validator: _validatePassword,
                              onFieldSubmitted: (_) => _submit(),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  onPressed: () => setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  }),
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                ),
                              ),
                            ),
                            if (_errorText != null) ...[
                              const SizedBox(height: 14),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.danger.withValues(
                                    alpha: 0.08,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.danger.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: AppColors.danger,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _errorText!,
                                        style: const TextStyle(
                                          color: AppColors.danger,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 18),
                            ElevatedButton(
                              onPressed: _submitting ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              child: _submitting
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.textOnPrimary,
                                      ),
                                    )
                                  : const Text('Sign in'),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                TextButton(
                                  onPressed: _submitting
                                      ? null
                                      : () => Navigator.of(context)
                                          .pushNamed(AppRoutes.register),
                                  child: const Text('Register as intern'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _DemoCredentialsHint(),
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

class _DemoCredentialsHint extends StatelessWidget {
  const _DemoCredentialsHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.textOnPrimary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Demo accounts (Spiral 1 — mock auth)',
            style: TextStyle(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'admin@prolink.dz / admin123\n'
            'mentor@prolink.dz / mentor123\n'
            'sara.benali@univ-constantine2.dz / sara123',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
