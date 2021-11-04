import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: isLoading ? const CircularProgressIndicator() : Text(label),
      onPressed: isLoading ? null : onPressed,
    );
  }
}
