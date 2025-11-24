import 'package:flutter/material.dart';
import '../src/design_tokens.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final bool fullWidth;

  const PrimaryButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.fullWidth = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      backgroundColor: Tokens.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
          vertical: Tokens.spacingSmall, horizontal: Tokens.spacingMedium),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: TextStyle(fontSize: Tokens.body, fontWeight: FontWeight.w600),
    );

    final button =
        ElevatedButton(onPressed: onPressed, style: style, child: child);

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
