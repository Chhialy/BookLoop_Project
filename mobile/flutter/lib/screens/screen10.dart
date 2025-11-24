import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../src/design_tokens.dart';
import '../widgets/primary_button.dart';

class Screen10 extends StatelessWidget {
  const Screen10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 10')),
      body: Padding(
        padding: const EdgeInsets.all(Tokens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Screen 10',
                style: TextStyle(
                    fontSize: Tokens.h2, fontWeight: FontWeight.w600)),
            const SizedBox(height: Tokens.spacingSmall),
            Text('Placeholder for Figma design (node-id: 15-1432)',
                style: TextStyle(color: Tokens.textSecondary)),
            const SizedBox(height: Tokens.spacingLarge),
            // Example content area
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Tokens.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                  child: Text('Content area',
                      style: TextStyle(color: Tokens.textPrimary))),
            ),
            const Spacer(),
            Row(children: [
              PrimaryButton(
                  onPressed: () => context.go('/screen09'),
                  child: const Text('Back')),
              const SizedBox(width: Tokens.spacingMedium),
              PrimaryButton(
                  onPressed: () => context.go('/screen11'),
                  child: const Text('Next')),
            ])
          ],
        ),
      ),
    );
  }
}
