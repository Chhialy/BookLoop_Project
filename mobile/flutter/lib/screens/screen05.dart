import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../src/design_tokens.dart';

class Screen05 extends StatelessWidget {
  const Screen05({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 05')),
      body: Padding(
        padding: const EdgeInsets.all(Tokens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Screen 05', style: TextStyle(fontSize: Tokens.h2, fontWeight: FontWeight.w600)),
            const SizedBox(height: Tokens.spacingMedium),
            Text('Placeholder for Figma design (node-id: 15-921)', style: TextStyle(color: Tokens.textSecondary)),
            const SizedBox(height: Tokens.spacingLarge),
            ElevatedButton(onPressed: () => context.go('/screen06'), child: const Text('Next')),
          ],
        ),
      ),
    );
  }
}
