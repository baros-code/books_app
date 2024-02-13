import 'package:flutter/material.dart';

import 'custom_text.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size,
  });

  final String text;
  final Size? size;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: size ?? const Size(double.infinity, 44),
        textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: onPressed == null ? FontWeight.w400 : FontWeight.w500,
            ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: CustomText(text, isSingleLine: true),
      ),
    );
  }
}
