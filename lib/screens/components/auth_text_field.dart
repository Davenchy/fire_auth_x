import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    Key? key,
    required this.label,
    this.controller,
    this.icon,
    this.focus = false,
    this.isPassword = false,
    this.isFinal = false,
    this.onSubmitted,
    this.keyboardType,
  }) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final IconData? icon;
  final bool focus;
  final bool isPassword;
  final bool isFinal;
  final TextInputType? keyboardType;
  final VoidCallback? onSubmitted;

  @override
  _AuthTextFieldState createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late final FocusNode _focusNode;

  initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      autofocus: widget.focus,
      obscureText: widget.isPassword,
      keyboardType: widget.keyboardType,
      textInputAction:
          widget.isFinal ? TextInputAction.done : TextInputAction.next,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSubmitted: (_) => widget.isFinal
          ? widget.onSubmitted?.call()
          : Focus.maybeOf(context)?.nextFocus(),
    );
  }
}
