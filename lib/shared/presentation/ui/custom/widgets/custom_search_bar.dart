import 'package:flutter/material.dart';

import '../../../extensions/build_context_ext.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    this.height,
    this.hintText,
    this.onTextChanged,
    this.onSubmitted,
    this.color,
    this.iconColor,
    this.enableKeyboardFirst = false,
  });

  final double? height;
  final String? hintText;
  final Color? color;
  final Color? iconColor;
  final bool enableKeyboardFirst;
  final void Function(String)? onTextChanged;
  final void Function(String)? onSubmitted;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 44,
      child: TextField(
        autofocus: widget.enableKeyboardFirst,
        controller: _controller,
        onChanged: widget.onTextChanged,
        onSubmitted: widget.onSubmitted,
        onEditingComplete: () {
          widget.onSubmitted?.call(_controller.text);
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        style: context.textTheme.bodySmall,
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: widget.color ?? context.colorScheme.secondary,
          contentPadding: const EdgeInsets.only(right: 8),
          prefixIcon: Transform.translate(
            offset: const Offset(4, 0),
            child: Icon(Icons.search, color: widget.iconColor),
          ),
          prefixIconConstraints: const BoxConstraints.expand(width: 40),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  splashRadius: 20,
                  onPressed: () {
                    _controller.clear();
                    widget.onTextChanged?.call(_controller.text);
                  },
                )
              : null,
          filled: true,
        ),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
