import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../src/design_tokens.dart';

class Screen01 extends StatelessWidget {
  const Screen01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Container(
        color: Tokens.background,
        padding: const EdgeInsets.all(Tokens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to BookLoop',
              style: TextStyle(fontSize: Tokens.h1, color: Tokens.textPrimary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: Tokens.spacingMedium),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Tokens.spacingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Screen 01 — Placeholder for Figma design (node-id: 15-217)',
                        style: TextStyle(fontSize: Tokens.body, color: Tokens.textSecondary)),
                    const SizedBox(height: Tokens.spacingMedium),
                    ElevatedButton(
                      onPressed: () => context.go('/screen02'),
                      child: const Text('Open next screen'),
                    ),
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
