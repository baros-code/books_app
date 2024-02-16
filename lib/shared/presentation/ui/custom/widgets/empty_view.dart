import 'package:flutter/material.dart';

import '../../../../../configs/asset_config.dart';
import '../../../extensions/build_context_ext.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    this.text,
    this.imagePath,
    this.textStyle,
  });

  final String? text;
  final String? imagePath;
  final TextStyle? textStyle;

  const EmptyView.builder({
    super.key,
    this.text,
    this.imagePath = AssetConfig.bookPlaceHolder,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.25;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            imagePath ?? AssetConfig.bookPlaceHolder,
            height: screenHeight * 0.25,
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
          ),
          if (text != null)
            Positioned(
              bottom: imageHeight * 0.1,
              child: Text(
                text!,
                style: textStyle ?? context.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
