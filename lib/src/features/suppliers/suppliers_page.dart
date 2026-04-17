import 'package:flutter/material.dart';

/// Suppliers feature starter file.
class SuppliersFeature {
  const SuppliersFeature();
}

class SuppliersView extends StatelessWidget {
  const SuppliersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suppliers')),
      body: const Center(child: Text('Suppliers feature placeholder')),
    );
  }
}
