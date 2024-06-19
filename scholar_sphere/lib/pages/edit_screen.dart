// lib/screens/edit_screen.dart
import 'package:flutter/material.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
      ),
      body: const Center(
        child: Text('Edit Your Account Screen'),
      ),
    );
  }
}

