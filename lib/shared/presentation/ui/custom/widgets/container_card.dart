import 'package:flutter/material.dart';

import '../../../extensions/build_context_ext.dart';

class ContainerCard extends StatelessWidget {
  const ContainerCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(12),
    this.borderRadius = 16,
    this.borderWidth = 1.0,
    this.borderColor,
    this.hideArrowIcon = false,
    this.enableBorder = false,
    this.enableShadows = false,
    this.enableSplash = true,
    this.isFlexible = false,
    this.spreadRadius = 0,
    this.onDoubleTap,
    this.onLongPress,
  });

  final Widget child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final double borderRadius;
  final double borderWidth;
  final Color? borderColor;
  final bool hideArrowIcon;
  final bool enableBorder;
  final bool enableShadows;
  final bool enableSplash;
  final bool isFlexible;
  final double spreadRadius;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.secondary,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        border: enableBorder
            ? Border.all(
                width: borderWidth,
                color: borderColor ?? context.colorScheme.primary,
              )
            : null,
        boxShadow: enableShadows
            ? [
                BoxShadow(
                  color: context.colorScheme.shadow.withOpacity(0.06),
                  spreadRadius: spreadRadius,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
                BoxShadow(
                  color: context.colorScheme.shadow.withOpacity(0.1),
                  spreadRadius: spreadRadius,
                  blurRadius: 8,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          highlightColor:
              enableSplash ? context.colorScheme.secondary : Colors.transparent,
          child: Container(
            width: width,
            height: height,
            padding: padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: isFlexible ? MainAxisSize.min : MainAxisSize.max,
              children: [
                isFlexible ? Flexible(child: child) : Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
