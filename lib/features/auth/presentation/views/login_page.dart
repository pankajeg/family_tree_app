import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/feedback/app_scaffold_messenger.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/network/exceptions/api_exception.dart';
import '../../../../core/presentation/viewmodels/app_settings_view_model.dart';
import '../../../admin/presentation/views/admin_dashboard_shell.dart';
import '../viewmodels/auth_view_model.dart';
import '../../../user/presentation/views/user_dashboard_shell.dart';
import 'register_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final response = await ref.read(authViewModelProvider.notifier).login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      final apiRole = response.data.user.role.toLowerCase();
      final role = apiRole.contains('admin') ? UserRole.admin : UserRole.member;

      ref.read(appSettingsProvider.notifier).setSession(
            accessToken: response.data.accessToken,
            userName: response.data.user.name,
            userEmail: response.data.user.email,
            role: role,
          );

      final page = role == UserRole.admin
          ? const AdminDashboardShell()
          : const UserDashboardShell();

      if (!mounted) {
        return;
      }

      await AppNavigator.pushReplacement<void, void>(context, page);
    } catch (error) {
      final settings = ref.read(appSettingsProvider);
      final l10n = AppLocalizations.of(settings.locale);
      final message = error is ApiException
          ? error.message
          : l10n.loginFailed;

      if (!mounted) {
        return;
      }

      AppScaffoldMessenger.showError(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(appSettingsProvider);
    final l10n = AppLocalizations.of(settings.locale);
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      l10n.adminLogin,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(value: 'en', label: Text('English')),
                        ButtonSegment(value: 'ar', label: Text('العربية')),
                      ],
                      selected: {settings.locale.languageCode},
                      onSelectionChanged: (_) {
                        ref.read(appSettingsProvider.notifier).toggleLanguage();
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: l10n.email,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: l10n.password,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) => (value == null || value.length < 6)
                          ? l10n.minimum6Characters
                          : null,
                    ),
                    const SizedBox(height: 14),
                    FilledButton(
                      onPressed: authState.isLoading ? null : _submit,
                      child: authState.isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.login),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        AppNavigator.push<void>(context, const RegisterPage());
                      },
                      child: Text(l10n.createAccount),
                    ),
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
