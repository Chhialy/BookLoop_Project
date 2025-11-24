import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../src/design_tokens.dart';

class Screen06 extends StatelessWidget {
  const Screen06({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 06')),
      body: Padding(
        padding: const EdgeInsets.all(Tokens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Screen 06', style: TextStyle(fontSize: Tokens.h2, fontWeight: FontWeight.w600)),
            const SizedBox(height: Tokens.spacingMedium),
            Text('Placeholder for Figma design (node-id: 15-297)', style: TextStyle(color: Tokens.textSecondary)),
            const SizedBox(height: Tokens.spacingLarge),
            Row(
              children: [
                ElevatedButton(onPressed: () => context.go('/screen07'), child: const Text('Next')),
                const SizedBox(width: Tokens.spacingSmall),
                OutlinedButton(onPressed: () => context.go('/screen05'), child: const Text('Back')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
