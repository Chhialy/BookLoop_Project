import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../src/design_tokens.dart';

class Screen04 extends StatelessWidget {
  const Screen04({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 04')),
      body: Padding(
        padding: const EdgeInsets.all(Tokens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Screen 04',
                style: TextStyle(
                    fontSize: Tokens.h2, fontWeight: FontWeight.w600)),
            const SizedBox(height: Tokens.spacingMedium),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Tokens.spacingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Placeholder for Figma design (node-id: 15-809)',
                        style: TextStyle(color: Tokens.textSecondary)),
                    const SizedBox(height: Tokens.spacingMedium),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () => context.go('/screen05'),
                            child: const Text('Next')),
                        const SizedBox(width: Tokens.spacingSmall),
                        OutlinedButton(
                            onPressed: () => context.go('/'),
                            child: const Text('Back home')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
