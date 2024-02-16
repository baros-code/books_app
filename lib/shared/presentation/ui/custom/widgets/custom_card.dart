import 'package:flutter/material.dart';

import '../../../extensions/build_context_ext.dart';
import '../../../extensions/widget_ext.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.width,
    this.height,
    this.constraints,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.showBorder = false,
    this.borderWidth = 1,
    this.shape,
    this.padding = const EdgeInsets.all(20),
    this.child,
  });

  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final bool showBorder;
  final double borderWidth;
  final ShapeBorder? shape;
  final EdgeInsets padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      padding: padding,
      decoration: _buildDecoration(context),
      child: child,
    ).bordered(
      isEnabled: showBorder,
      width: borderWidth,
      borderColor: borderColor ?? context.colorScheme.primary,
      radius: borderRadius ?? BorderRadius.circular(16),
    );
  }

  // Helpers
  Decoration _buildDecoration(BuildContext context) {
    return shape != null
        ? ShapeDecoration(
            shape: shape!,
            color: backgroundColor ?? context.colorScheme.background,
          )
        : BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            color: backgroundColor ?? context.colorScheme.background,
          );
  }
  // - Helpers
}
