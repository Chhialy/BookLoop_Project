import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../src/design_tokens.dart';
import '../widgets/primary_button.dart';

class Screen09 extends StatelessWidget {
  const Screen09({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 09')),
      body: Padding(
        padding: const EdgeInsets.all(Tokens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Screen 09',
                style: TextStyle(
                    fontSize: Tokens.h2, fontWeight: FontWeight.w600)),
            const SizedBox(height: Tokens.spacingSmall),
            Text('Placeholder for Figma design (node-id: 15-1431)',
                style: TextStyle(color: Tokens.textSecondary)),
            const Spacer(),
            Row(children: [
              PrimaryButton(
                  onPressed: () => context.go('/screen08'),
                  child: const Text('Back')),
              const SizedBox(width: Tokens.spacingMedium),
              PrimaryButton(
                  onPressed: () => context.go('/screen10'),
                  child: const Text('Continue')),
            ])
          ],
        ),
      ),
    );
  }
}
