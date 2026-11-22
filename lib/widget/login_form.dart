
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:item_details_app/providers/demo_session.dart';
import 'package:item_details_app/providers/login_provider.dart';
import 'package:item_details_app/screens/name_screen.dart';
import 'package:item_details_app/theme/app_colors.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isSignUp = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void toggleMode() {
    setState(() {
      isSignUp = !isSignUp;
    });

    formKey.currentState?.reset();

    passwordController.clear();
    confirmPasswordController.clear();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final notifier = ref.read(loginProvider.notifier);

    String? error;

    if (isSignUp) {
      error = await notifier.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } else {
      error = await notifier.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }

    if (!mounted) return;

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
        ),
      );
      return;
    }

    DemoSession.email = emailController.text.trim();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ChooseNameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined,
                color: AppColors.primary,),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }

              if (!value.contains('@')) {
                return 'Enter a valid email';
              }

              return null;
            },
          ),

          const SizedBox(height: 16),

          TextFormField(
            controller: passwordController,
            obscureText: state.isPasswordHidden,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline ,
                color: AppColors.primary,),
              suffixIcon: IconButton(
                onPressed: () {
                  ref
                      .read(loginProvider.notifier)
                      .togglePassword();
                },
                icon: Icon(
                  state.isPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppColors.primary,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }

              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }

              return null;
            },
          ),

          if (isSignUp) ...[
            const SizedBox(height: 16),

            TextFormField(
              controller: confirmPasswordController,
              obscureText: state.isConfirmPasswordHidden,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: const Icon(Icons.lock_outline,
                  color: AppColors.primary,),
                suffixIcon: IconButton(
                  onPressed: () {
                    ref
                        .read(loginProvider.notifier)
                        .toggleConfirmPassword();
                  },
                  icon: Icon(
                    state.isConfirmPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.primary,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }

                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }

                return null;
              },
            ),
          ],

          if (!isSignUp) ...[
            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                ),
              ),
            ),
          ],

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: state.isLoading ? null : submit,
                child: state.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        isSignUp ? 'SIGN UP' : 'LOGIN',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isSignUp
                    ? 'Already have an account? '
                    : "Don't have an account? ",
              ),
              InkWell(
                onTap: toggleMode,
                child: Text(
                  isSignUp ? 'Login' : 'Sign Up',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
