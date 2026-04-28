import 'package:ashfoam_sadiq/src/core/theme/app_colors.dart';
import 'package:ashfoam_sadiq/src/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // You could use a snackbar or toast
      toastification.show(
        title: const Text("Please enter both email and password"),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 3),
      );
      return;
    }

    await ref.read(authNotifierProvider.notifier).signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    // Listen for errors and show them
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          String message = "An unexpected error occurred. Please try again.";

          if (error is AuthException) {
            final sysMessage = error.message.toLowerCase();
            if (sysMessage.contains("invalid login credentials")) {
              message = "Invalid email or password. Please try again.";
            } else if (sysMessage.contains("email not confirmed")) {
              message = "Please confirm your email address before signing in.";
            } else if (sysMessage.contains("too many requests")) {
              message =
                  "Too many login attempts. Please wait a moment and try again.";
            } else if (sysMessage.contains("network")) {
              message =
                  "Network connection failed. Please check your internet.";
            } else {
              message = error.message;
            }
          }

          toastification.show(
            title: Text(message),
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 3),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: AppColors.yellow17,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or App Icon
                Image.asset("assets/ashfoam_logo.png"),

                const SizedBox(height: 32),
                FCard(
                  title: Center(
                    child: Text(
                      "Sign In",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  subtitle: Center(
                    child: const Text(
                      "Provide your registered email and password",
                    ),
                  ),
                  child: AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Email Address",

                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FTextField(
                          autofillHints: const [AutofillHints.email],
                          control: FTextFieldControl.managed(
                            controller: _emailController,
                          ),
                          hint: "e.g. admin@ashfoam.com",
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Password",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FTextField(
                          autofillHints: const [AutofillHints.password],

                          control: FTextFieldControl.managed(
                            controller: _passwordController,
                          ),
                          hint: "••••••••",
                          obscureText: !_isPasswordVisible,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FButton(
                              variant: FButtonVariant.ghost,
                              onPress: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: Text(
                                _isPasswordVisible
                                    ? "Hide Password"
                                    : "Show Password",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: FButton(
                            onPress: authState.isLoading ? null : _handleLogin,

                            child: authState.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text("Sign In"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "v1.2.4 (Build 45)",
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
