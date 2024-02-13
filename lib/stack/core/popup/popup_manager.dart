// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// A tool to show/hide pre-defined or custom popups.
abstract class PopupManager {
  /// Shows a general dialog above the current contents of the app.
  /// [content] specifies the widget to be shown inside the dialog.
  /// [alignment] specifies the alignment of the dialog.
  /// [padding] adds a padding around the dialog.
  /// [barrierColor] specifies the color of the background barrier.
  /// [preventClose] prevents closing the dialog by pressing outside.
  /// [preventBackPress] prevents closing the dialog by pressing back button.
  Future<void> showPopup(
    BuildContext context,
    Widget content, {
    Alignment alignment,
    EdgeInsets padding,
    Color? barrierColor,
    bool preventClose,
    bool preventBackPress,
  });

  /// Shows a full screen dialog above the current contents of the app.
  /// [content] specifies the widget to be shown inside the dialog.
  /// [preventBackPress] prevents closing the dialog by pressing back button.
  Future<void> showFullScreenPopup(
    BuildContext context,
    Widget content, {
    bool preventBackPress,
  });

  /// Shows a bottom sheet dialog above the current contents of the app.
  /// [content] specifies the widget to be shown inside the dialog.
  /// [width] specifies the width of the dialog.
  /// [height] specifies the height of the dialog.
  /// [borderRadius] specifies the border radius of the dialog.
  /// [barrierColor] specifies the color of the background barrier.
  /// [preventClose] prevents closing the dialog by pressing outside.
  /// [preventBackPress] prevents closing the dialog by pressing back button.
  /// [enableDrag] enables dragging functionality of the dialog.
  Future<void> showBottomPopup(
    BuildContext context,
    Widget content, {
    double width,
    double height,
    double borderRadius,
    Color? barrierColor,
    bool preventClose,
    bool preventBackPress,
    bool enableDrag,
  });
}

class PopupManagerImpl implements PopupManager {
  @override
  Future<void> showPopup(
    BuildContext context,
    Widget content, {
    Alignment alignment = Alignment.center,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 20,
    ),
    Color? barrierColor,
    bool preventClose = false,
    bool preventBackPress = false,
  }) {
    return _showGeneralDialog(
      context,
      content,
      alignment: alignment,
      padding: padding,
      preventClose: preventClose,
      preventBackPress: preventBackPress,
      barrierColor: barrierColor,
      showFullScreen: false,
    );
  }

  @override
  Future<void> showFullScreenPopup(
    BuildContext context,
    Widget content, {
    bool preventBackPress = false,
  }) {
    return _showGeneralDialog(
      context,
      content,
      preventBackPress: preventBackPress,
      showFullScreen: true,
      enableSlideAnimation: true,
    );
  }

  @override
  Future<void> showBottomPopup(
    BuildContext context,
    Widget content, {
    double width = double.infinity,
    double height = double.infinity,
    double borderRadius = 0,
    Color? barrierColor,
    bool preventClose = false,
    bool preventBackPress = false,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet(
      context: context,
      enableDrag: enableDrag,
      isScrollControlled: enableDrag,
      isDismissible: !preventClose,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      barrierColor: barrierColor ?? Colors.black26,
      constraints: BoxConstraints(
        maxWidth: width,
        maxHeight: height,
      ),
      builder: (_) {
        return SafeArea(
          child: WillPopScope(
            onWillPop: () async => !preventBackPress,
            child: content,
          ),
        );
      },
    );
  }

  // Helpers
  Future<void> _showGeneralDialog(
    BuildContext context,
    Widget content, {
    Alignment? alignment,
    EdgeInsets? padding,
    bool? preventClose,
    Color? barrierColor,
    required bool preventBackPress,
    required bool showFullScreen,
    bool enableSlideAnimation = false,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: preventClose != null ? !preventClose : true,
      barrierLabel: MaterialLocalizations.of(
        context,
      ).modalBarrierDismissLabel,
      barrierColor: barrierColor ?? Colors.black26,
      transitionBuilder: enableSlideAnimation
          ? (_, anim1, __, child) {
              return SlideTransition(
                position: Tween(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(anim1),
                child: child,
              );
            }
          : null,
      pageBuilder: (_, __, ___) {
        return SafeArea(
          left: !showFullScreen,
          top: !showFullScreen,
          right: !showFullScreen,
          bottom: !showFullScreen,
          child: WillPopScope(
            onWillPop: () async => !preventBackPress,
            child: Align(
              alignment: alignment ?? Alignment.center,
              child: Padding(
                padding: showFullScreen
                    ? EdgeInsets.zero
                    : padding ?? EdgeInsets.zero,
                child: content,
              ),
            ),
          ),
        );
      },
    );
  }
  // - Helpers
}
