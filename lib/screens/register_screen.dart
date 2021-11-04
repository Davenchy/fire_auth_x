import 'package:fire_auth_x/controllers/auth_controller.dart';
import 'package:fire_auth_x/screens/components/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/auth_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
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
                  'Create New Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                AuthTextField(
                  controller: _usernameController,
                  label: 'Username',
                  icon: Icons.person,
                  keyboardType: TextInputType.name,
                  focus: true,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _emailController,
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
                  onSubmitted: _register,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: Obx(
                    () => AuthButton(
                      label: 'Create Account',
                      isLoading: AuthController.instance.isLoading.value,
                      onPressed: _register,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(width: 8),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Login!",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () => Get.offAndToNamed('/login'),
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

  void _register() => AuthController.instance.register(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
}
