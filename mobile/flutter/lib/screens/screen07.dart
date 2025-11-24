import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../src/design_tokens.dart';
import '../widgets/primary_button.dart';

class Screen07 extends StatelessWidget {
  const Screen07({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 07')),
      body: Padding(
        padding: const EdgeInsets.all(Tokens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Screen 07',
                style: TextStyle(
                    fontSize: Tokens.h2, fontWeight: FontWeight.w600)),
            const SizedBox(height: Tokens.spacingMedium),
            Text('Placeholder for Figma design (node-id: 15-1429)',
                style: TextStyle(color: Tokens.textSecondary)),
            const SizedBox(height: Tokens.spacingLarge),
            PrimaryButton(
                onPressed: () => context.go('/screen08'),
                child: const Text('Next')),
          ],
        ),
      ),
    );
  }
}
