import 'package:flutter/material.dart';

class Screen01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 01')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Screen 01 — Placeholder for Figma design (node-id: 15-217)'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/screen02'),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
