import 'package:flutter/material.dart';

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
    required this.onSubmitted,
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
  final void Function(String) onSubmitted;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    const transparentColor = MaterialStatePropertyAll(Colors.transparent);
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            constraints: const BoxConstraints(
              minHeight: 48,
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            ),
            hintText: widget.hintText,
            textStyle: MaterialStatePropertyAll(
              widget.textStyle ?? const TextStyle(color: Colors.white),
            ),
            side: MaterialStatePropertyAll(BorderSide(
              width: _searchText.isEmpty ? 1 : 2,
              color: _searchText.isEmpty
                  ? (widget.inActiveBorderColor ?? Colors.white)
                  : (widget.activeBorderColor ?? const Color(0xFF4893EB)),
            )),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            hintStyle: MaterialStatePropertyAll(
              widget.hintStyle ?? const TextStyle(color: Colors.white),
            ),
            leading: widget.leading,
            backgroundColor: MaterialStatePropertyAll(
              widget.backgroundColor ?? Colors.transparent,
            ),
            shadowColor: transparentColor,
            surfaceTintColor: transparentColor,
            overlayColor: transparentColor,
            onSubmitted: (value) => widget.submitWithEnterEnabled
                ? widget.onSubmitted(value)
                : null,
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => widget.onSubmitted(_searchText),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(0, 20),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            backgroundColor: widget.buttonColor ?? const Color(0xFF4893EB),
          ),
          child: Text(
            widget.buttonText ?? 'Search',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
