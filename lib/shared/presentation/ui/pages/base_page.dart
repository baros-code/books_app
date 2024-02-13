import '../../extensions/widget_ext.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    this.title,
    this.body,
    this.bottom,
    this.floatingActionButton,
    this.backgroundColor,
    this.appBarBackgroundColor,
    this.appBarDisabled = false,
    this.backButtonEnabled = false,
    this.closeButtonEnabled = false,
    this.isBodyRounded = false,
    this.centerTitle = false,
    this.safeAreaEnabled = true,
    this.appBarbottom,
    this.bodyPadding,
    this.actions,
    this.onBackButtonPressed,
    this.onCloseButtonPressed,
    this.onDismissed,
  });

  final Widget? title;
  final Widget? body;
  final Widget? bottom;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final bool appBarDisabled;
  final bool backButtonEnabled;
  final bool closeButtonEnabled;
  final bool isBodyRounded;
  final bool centerTitle;
  final bool safeAreaEnabled;
  final PreferredSizeWidget? appBarbottom;
  final EdgeInsets? bodyPadding;
  final List<Widget>? actions;
  final void Function()? onBackButtonPressed;
  final void Function()? onCloseButtonPressed;
  final void Function()? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: floatingActionButton,
    ).backPressHandled(
      onBackPress: () async {
        onDismissed?.call();
        return true;
      },
    );
  }

  // Helpers
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leadingWidth: 52,
      leading: backButtonEnabled
          ? _BackButton(
              onBackButtonPressed,
              onDismissed,
            )
          : null,
      backgroundColor: appBarBackgroundColor,
      automaticallyImplyLeading: false,
      title: IntrinsicWidth(child: title),
      centerTitle: centerTitle,
      actions: _buildActions(),
      titleSpacing: backButtonEnabled ? 0 : null,
      toolbarHeight: !appBarDisabled ? kToolbarHeight : 0,
      bottom: appBarbottom,
    );
  }

  List<Widget> _buildActions() {
    return [
      if (actions != null) ...actions!,
      if (closeButtonEnabled) const SizedBox(width: 16),
      if (closeButtonEnabled)
        _CloseButton(
          onCloseButtonPressed,
          onDismissed,
        ),
      const SizedBox(width: 16),
    ];
  }

  Widget _buildBody() {
    return SafeArea(
      left: safeAreaEnabled,
      top: safeAreaEnabled,
      right: safeAreaEnabled,
      bottom: safeAreaEnabled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (body != null)
            Expanded(
              child: _PageBody(
                backgroundColor: backgroundColor,
                padding: bodyPadding,
                isRounded: isBodyRounded,
                child: body!,
              ),
            ),
          if (body == null) const Spacer(),
          _Bottom(bottom),
        ],
      ),
    );
  }
  // - Helpers
}

class _BackButton extends StatelessWidget {
  const _BackButton(
    this.onBackButtonPressed,
    this.onDismissed,
  );

  final void Function()? onBackButtonPressed;
  final void Function()? onDismissed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 28,
      splashRadius: 24,
      icon: const Icon(Icons.keyboard_backspace),
      onPressed: () => _onPressed(context),
    );
  }

  // Helpers
  void _onPressed(BuildContext context) {
    if (onBackButtonPressed == null) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
        onDismissed?.call();
      }
    } else {
      onBackButtonPressed!.call();
    }
  }
  // - Helpers
}

class _CloseButton extends StatelessWidget {
  const _CloseButton(
    this.onCloseButtonPressed,
    this.onDismissed,
  );

  final void Function()? onCloseButtonPressed;
  final void Function()? onDismissed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      iconSize: 28,
      onPressed: () => _onPressed(context),
    );
  }

  // Helpers
  void _onPressed(BuildContext context) {
    if (onCloseButtonPressed == null) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
        onDismissed?.call();
      }
    } else {
      onCloseButtonPressed!.call();
    }
  }
  // - Helpers
}

class _PageBody extends StatelessWidget {
  const _PageBody({
    this.backgroundColor,
    this.padding,
    required this.isRounded,
    required this.child,
  });

  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool isRounded;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      clipBehavior: isRounded ? Clip.antiAlias : Clip.none,
      child: Container(
        color: backgroundColor,
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom(this.bottom);

  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 100),
      child: Container(
        height: bottom != null ? null : 0,
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: bottom,
      ).elevated(
        isTop: true,
        borderRadius: 0,
        blurRadius: 8,
        level: 2,
      ),
    );
  }
}
