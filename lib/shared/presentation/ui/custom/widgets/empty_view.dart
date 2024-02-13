import 'package:flutter/material.dart';

import '../../../extensions/build_context_ext.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.text,
    this.imagePath,
    this.textStyle,
    this.imageScale = 2,
    this.textDistanceFromImage = 16,
    this.onTryAgain,
  });

  final String text;
  final TextStyle? textStyle;
  final String? imagePath;
  final double imageScale;
  final double? textDistanceFromImage;
  final VoidCallback? onTryAgain;

  const EmptyView.builder({
    super.key,
    required this.text,
    this.imagePath = 'CommonImages.emptyPositive',
    this.textStyle,
    this.imageScale = 2,
    this.textDistanceFromImage,
    this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath ?? 'CommonImages.emptyNegative',
            scale: imageScale,
          ),
          SizedBox(height: textDistanceFromImage ?? 16),
          Flexible(
            child: Text(
              text,
              style: textStyle ??
                  context.textTheme.bodySmall!.apply(
                    color: context.colorScheme.secondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
