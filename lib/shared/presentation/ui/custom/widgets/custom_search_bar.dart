import 'package:flutter/material.dart';

import '../../../extensions/build_context_ext.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.leading,
    this.backgroundColor,
    this.activeBorderColor,
    this.inActiveBorderColor,
    this.buttonColor,
    this.buttonText,
    this.submitWithEnterEnabled = true,
    this.onChange,
    this.onSubmitted,
  });

  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? activeBorderColor;
  final Color? inActiveBorderColor;
  final Color? buttonColor;
  final String? buttonText;
  final bool submitWithEnterEnabled;
  final void Function(String)? onChange;
  final void Function(String)? onSubmitted;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const transparentColor = MaterialStatePropertyAll(Colors.transparent);
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            controller: _controller,
            constraints: const BoxConstraints(
              minHeight: 48,
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            ),
            hintText: widget.hintText,
            textStyle: MaterialStatePropertyAll(
              widget.textStyle ??
                  context.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.normal),
            ),
            side: MaterialStatePropertyAll(
              BorderSide(
                width: _controller.text.isEmpty ? 1 : 2,
                color: _controller.text.isEmpty
                    ? (widget.inActiveBorderColor ?? Colors.white)
                    : (widget.activeBorderColor ?? context.colorScheme.primary),
              ),
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            hintStyle: MaterialStatePropertyAll(widget.hintStyle),
            leading: widget.leading,
            trailing: _controller.text.isNotEmpty
                ? [
                    _buildClearButton(),
                  ]
                : null,
            backgroundColor: MaterialStatePropertyAll(
              widget.backgroundColor ?? context.colorScheme.background,
            ),
            shadowColor: transparentColor,
            surfaceTintColor: transparentColor,
            overlayColor: transparentColor,
            onChanged: (_) {
              setState(() {
                widget.onChange?.call(_controller.text);
              });
            },
            onSubmitted: (_) => widget.submitWithEnterEnabled
                ? widget.onSubmitted?.call(_controller.text)
                : null,
          ),
        ),
        if (widget.onSubmitted != null) ...[
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => widget.onSubmitted?.call(_controller.text),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 20),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor:
                  widget.buttonColor ?? context.colorScheme.primary,
            ),
            child: Text(
              widget.buttonText ?? 'Search',
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Helpers
  GestureDetector _buildClearButton() {
    return GestureDetector(
      child: const Icon(Icons.close),
      onTap: () {
        setState(() {
          _controller.clear();
          _dispatchCallback();
        });
      },
    );
  }

  void _dispatchCallback() {
    if (widget.onSubmitted != null) {
      widget.onSubmitted?.call(_controller.text);
    } else {
      widget.onChange?.call(_controller.text);
    }
  }
  // - Helpers
}
