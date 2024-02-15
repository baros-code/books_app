// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget bordered({
    Color? borderColor,
    Color? backgroundColor,
    BorderRadius? radius,
    EdgeInsets? padding,
    double width = 1.0,
    bool isEnabled = true,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: isEnabled
            ? Border.all(
                width: width,
                color: borderColor ?? Colors.black,
              )
            : null,
        borderRadius: radius,
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(width),
        child: this,
      ),
    );
  }
}
