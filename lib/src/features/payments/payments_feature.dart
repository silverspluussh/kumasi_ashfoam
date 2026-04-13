import 'package:flutter/material.dart';

/// Payments feature starter file.
class PaymentsFeature {
  const PaymentsFeature();
}

class PaymentsView extends StatelessWidget {
  const PaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payments')),
      body: const Center(child: Text('Payments feature placeholder')),
    );
  }
}
