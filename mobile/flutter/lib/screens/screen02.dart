import 'package:flutter/material.dart';

class Screen02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 02')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Screen 02 — Placeholder for Figma design (node-id: 15-440)'),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/screen03'),
                child: Text('Next'))
          ],
        ),
      ),
    );
  }
}
