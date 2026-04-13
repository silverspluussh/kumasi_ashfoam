import 'package:flutter/material.dart';

/// POS feature starter file.
class PosFeature {
  const PosFeature();
}

class PosView extends StatelessWidget {
  const PosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Point of Sale')),
      body: const Center(child: Text('POS feature placeholder')),
    );
  }
}
