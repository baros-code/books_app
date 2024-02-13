import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.autoBottomPadding = false,
    this.style,
    this.textAlign,
    this.tagColor,
    this.maxLines,
    this.overflow,
    this.xTagStyle,
    this.isSingleLine = false,
    this.onLinkPress,
    this.enabled = true,
  });

  /// The autoBottomPadding to use when the text need extra bottom padding.
  /// General use case is aligning the text vertically in a Row.
  ///
  /// Default value is false.
  ///
  /// If the style is null padding value will be 0.
  final bool autoBottomPadding;

  /// When you need to colorize a part of the [text], use the \<c\> tag.
  ///
  /// Set [tagColor] to determine the color of \<c\> tag.
  final Color? tagColor;

  /// To apply a custom TextStyle with \<x\> tag if necessary.
  final TextStyle? xTagStyle;

  /// Enables single line text, which means [maxLines] = 1 and
  /// [overflow] = [TextOverflow.ellipsis] if [overflow] is null.
  final bool isSingleLine;

  /// When you need to have a link for a part of the [text], use the \<l\> tag.
  ///
  /// Set [onLinkPress] to determine the callback of \<l\> tag.
  /// Currently doesn't support to have multiple links in a single text. So,
  /// this particular callback will be triggered for all the \<l\> tags.
  final void Function()? onLinkPress;

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: autoBottomPadding ? (_calculateBottomPadding(context) ?? 0) : 0,
      ),
      child: StyledText(
        text: text,
        style: enabled
            ? style
            : style?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
        textAlign: textAlign,
        maxLines: isSingleLine ? 1 : maxLines,
        overflow: isSingleLine
            ? (overflow ?? TextOverflow.ellipsis)
            : maxLines != null
                ? TextOverflow.ellipsis
                : overflow,
        tags: {
          'b': StyledTextTag(
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          'm': StyledTextTag(
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          'i': StyledTextTag(
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          'c': StyledTextTag(
            style: TextStyle(
              color: tagColor,
            ),
          ),
          'x': StyledTextTag(
            style: xTagStyle,
          ),
          'l': StyledTextWidgetBuilderTag((context, __, textContent) {
            return textContent != null
                ? _buildLinkButton(context, textContent)
                : const SizedBox.shrink();
          }),
        },
      ),
    );
  }

  // Helpers
  double? _calculateBottomPadding(BuildContext context) {
    final defaultFontSize = DefaultTextStyle.of(context).style.fontSize;
    final textStyle = style;
    final textHeight = textStyle?.height;
    final fontSize = textStyle?.fontSize ?? defaultFontSize;

    if (textStyle == null || textHeight == null || fontSize == null) {
      return null;
    }

    final lineHeight = textHeight * fontSize;
    return (lineHeight - fontSize) / 2;
  }

  Widget _buildLinkButton(BuildContext context, String textContent) {
    return GestureDetector(
      onTap: enabled ? onLinkPress : null,
      child: CustomText(
        textContent,
        style: style?.copyWith(
          color: !enabled ? Theme.of(context).colorScheme.onSecondary : null,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
        autoBottomPadding: autoBottomPadding,
      ),
    );
  }
  // - Helpers
}
