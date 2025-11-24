import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../src/design_tokens.dart';
import '../widgets/primary_button.dart';

class Screen11 extends StatelessWidget {
  const Screen11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 11')),
      body: Padding(
        padding: const EdgeInsets.all(Tokens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Screen 11',
                style: TextStyle(
                    fontSize: Tokens.h2, fontWeight: FontWeight.w600)),
            const SizedBox(height: Tokens.spacingSmall),
            Text('Placeholder for Figma design (node-id: 15-1433)',
                style: TextStyle(color: Tokens.textSecondary)),
            const SizedBox(height: Tokens.spacingLarge),
            // Final actions
            PrimaryButton(
                onPressed: () => context.go('/'), child: const Text('Finish')),
            const SizedBox(height: Tokens.spacingSmall),
            TextButton(
                onPressed: () => context.go('/screen10'),
                child: const Text('Back')),
          ],
        ),
      ),
    );
  }
}
