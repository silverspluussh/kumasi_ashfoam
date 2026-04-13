import 'package:flutter/material.dart';

/// Inventory feature starter file.
class InventoryFeature {
  const InventoryFeature();
}

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      body: const Center(child: Text('Inventory feature placeholder')),
    );
  }
}
