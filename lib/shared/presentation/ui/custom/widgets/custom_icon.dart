import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    this.icon,
    this.imageIcon,
    this.size = 24,
    this.color,
  })  : assert(
          icon == null || imageIcon == null,
          'Only one of icon and imageIcon can be provided',
        ),
        assert(
          icon != null || imageIcon != null,
          'Either icon or imageIcon should be provided',
        );

  final IconData? icon;
  final String? imageIcon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? Icon(
            icon,
            size: size,
            color: color,
          )
        : Image.asset(
            imageIcon!,
            width: size,
            height: size,
            color: color,
          );
  }
}
