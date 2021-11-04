import 'package:fire_auth_x/controllers/auth_controller.dart';
import 'package:fire_auth_x/screens/components/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/auth_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final viewPadding = mediaQuery.viewPadding;
    final actualHeight = height - viewPadding.top - viewPadding.bottom;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: actualHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Text(
                  'Access the world',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                AuthTextField(
                  controller: _emailController,
                  focus: true,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                  isFinal: true,
                  onSubmitted: _login,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: Obx(
                    () => AuthButton(
                      label: 'Login',
                      isLoading: AuthController.instance.isLoading.value,
                      onPressed: _login,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width: 8),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "Register Now!",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () => Get.offAndToNamed('/register'),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() => AuthController.instance.signIn(
        _emailController.text,
        _passwordController.text,
      );
}
