import 'package:flutter/material.dart';

import '../../../../constants/custom_images.dart';
import '../../../extensions/build_context_ext.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    this.text,
    this.imagePath,
    this.textStyle,
    this.imageWidth,
    this.imageHeight,
    this.textDistanceFromImage = 4,
    this.onTryAgain,
  });

  final String? text;
  final String? imagePath;
  final TextStyle? textStyle;
  final double? imageWidth;
  final double? imageHeight;
  final double? textDistanceFromImage;
  final VoidCallback? onTryAgain;

  const EmptyView.builder({
    super.key,
    this.text,
    this.imagePath = CustomImages.bookPlaceHolder,
    this.imageWidth,
    this.imageHeight,
    this.textStyle,
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
          Flexible(
            child: Image.asset(
              imagePath ?? CustomImages.bookPlaceHolder,
              width: imageWidth ?? 200,
              height: imageHeight ?? 200,
            ),
          ),
          SizedBox(height: textDistanceFromImage),
          if (text != null)
            Flexible(
              child: Text(
                text!,
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
