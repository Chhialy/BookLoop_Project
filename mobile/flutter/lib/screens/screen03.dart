import 'package:flutter/material.dart';
import '../src/design_tokens.dart';

class Screen03 extends StatelessWidget {
  const Screen03({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 03')),
      body: Padding(
        padding: const EdgeInsets.all(Tokens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Screen 03', style: TextStyle(fontSize: Tokens.h2, fontWeight: FontWeight.w600)),
            const SizedBox(height: Tokens.spacingMedium),
            Text('Placeholder for Figma design (node-id: 15-1025)', style: TextStyle(color: Tokens.textSecondary)),
          ],
        ),
      ),
    );
  }
}
