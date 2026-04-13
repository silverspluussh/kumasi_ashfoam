import 'package:flutter/material.dart';

/// Invoices feature starter file.
class InvoicesFeature {
  const InvoicesFeature();
}

class InvoicesView extends StatelessWidget {
  const InvoicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invoices')),
      body: const Center(child: Text('Invoices feature placeholder')),
    );
  }
}
