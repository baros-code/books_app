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

  Widget elevated({
    bool isTop = false,
    double level = 2,
    double blurRadius = 2,
    double borderRadius = 16,
    double opacity = 0.1,
    bool isEnabled = true,
  }) {
    return isEnabled
        ? DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(opacity),
                  blurRadius: blurRadius,
                  offset: Offset(0, isTop ? -level : level),
                ),
              ],
            ),
            child: this,
          )
        : this;
  }

  Widget centered({bool isEnabled = true}) {
    return isEnabled ? Center(child: this) : this;
  }

  Widget clippedRounded({double borderRadius = 16}) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: this,
    );
  }

  Widget clippedOval() {
    return ClipOval(
      clipBehavior: Clip.antiAlias,
      child: this,
    );
  }

  Widget tapHandled(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }

  Widget backPressHandled({Future<bool> Function()? onBackPress}) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: this,
    );
  }
}
