// lib/widgets/forward_button.dart
import 'package:flutter/material.dart';
class ForwardButton extends StatelessWidget {
  final VoidCallback onTap;

  const ForwardButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: const Icon(Icons.chair),
    );
  }
}
