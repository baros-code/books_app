// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:visibility_aware_state/visibility_aware_state.dart';

import '../../core/ioc/service_locator.dart';
import 'controller.dart';
import 'controller_provider.dart';

abstract class ControlledView<TController extends Controller<TParams>,
    TParams extends Object> extends StatefulWidget {
  ControlledView({
    super.key,
    required this.params,
  }) : controller = locator<TController>();

  /// Optional parameters that can be passed during navigation.
  final TParams? params;

  /// Controller of this view. It is to be used as a presentation logic holder.
  late final TController controller;

  /// Called when the view is activated on start or resume.
  @protected
  @mustCallSuper
  void onActivate() {}

  /// Called once when the view is initialized.
  @protected
  @mustCallSuper
  void onStart() {
    controller.logger.info(
      '${_getHashCodeString()} - onStart',
      callerType: runtimeType,
    );
  }

  /// Called once when the view started and whenever the dependencies change.
  @protected
  @mustCallSuper
  void onPostStart() {}

  /// Called after build is finished.
  @protected
  @mustCallSuper
  void onPostBuild() {}

  /// Called when the view is visible back from pause.
  @protected
  @mustCallSuper
  void onResume() {
    controller.logger.info(
      '${_getHashCodeString()} - onResume',
      callerType: runtimeType,
    );
  }

  /// Called when the view is visible on screen.
  @protected
  @mustCallSuper
  void onVisible() {}

  /// Called when the view is hidden on screen.
  @protected
  @mustCallSuper
  void onHidden() {}

  /// Called when the view goes invisible and running in the background.
  @protected
  @mustCallSuper
  void onPause() {
    controller.logger.info(
      '${_getHashCodeString()} - onPause',
      callerType: runtimeType,
    );
  }

  /// Called when the view is disposed. The difference between onStop and
  /// onClose is that onClose is called when the app is detached but
  /// onStop means the view is popped from the navigation stack.
  @protected
  @mustCallSuper
  void onStop() {
    controller.logger.info(
      '${_getHashCodeString()} - onStop',
      callerType: runtimeType,
    );
  }

  /// Called when the app is detached which usually happens when
  /// back button is pressed.
  @protected
  @mustCallSuper
  void onClose() {
    controller.logger.info(
      '${_getHashCodeString()} - onClose',
      callerType: runtimeType,
    );
  }

  /// Called when the view is deactivated on pause or close.
  @protected
  @mustCallSuper
  void onDeactivate() {}

  /// Called when back button is pressed.
  @protected
  @mustCallSuper
  Future<bool> onBackRequest() {
    controller.logger.info(
      '${_getHashCodeString()} - onBackRequest',
      callerType: runtimeType,
    );
    return Future.value(true);
  }

  @override
  // ignore: library_private_types_in_public_api
  _ControlledViewState<TController> createState() {
    // Create the view state with all the callbacks.
    // ignore: no_logic_in_create_state
    return _ControlledViewState(
      controller,
      buildView: (context) {
        return ControllerProvider(
          controller: controller,
          child: WillPopScope(
            // Handle back press.
            onWillPop: () async {
              if (!controller.isActive) return Future.value(false);
              return await onBackRequest() == await controller.onBackRequest();
            },
            child: build(context),
          ),
        );
      },
      onActivate: onActivate,
      onInitState: onStart,
      onPostInitState: onPostStart,
      onPostBuild: onPostBuild,
      onResume: onResume,
      onVisible: onVisible,
      onHidden: onHidden,
      onPause: onPause,
      onDispose: onStop,
      onDetach: onClose,
      onDeactivate: onDeactivate,
    );
  }

  /// Describes the widget to be constructed.
  @protected
  Widget build(BuildContext context);

  // Helpers
  String _getHashCodeString() {
    return '0x${hashCode.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }
  // - Helpers
}

// View state that handles all the lifecycle events.
class _ControlledViewState<TController extends Controller>
    extends VisibilityAwareState<ControlledView>
    with
        WidgetsBindingObserver,
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin {
  _ControlledViewState(
    this._controller, {
    required this.buildView,
    required this.onActivate,
    required this.onInitState,
    required this.onPostInitState,
    required this.onPostBuild,
    required this.onResume,
    required this.onVisible,
    required this.onHidden,
    required this.onPause,
    required this.onDispose,
    required this.onDetach,
    required this.onDeactivate,
  });

  final Controller _controller;
  final Widget Function(BuildContext context) buildView;
  final void Function() onActivate;
  final void Function() onInitState;
  final void Function() onPostInitState;
  final void Function() onPostBuild;
  final void Function() onResume;
  final void Function() onVisible;
  final void Function() onHidden;
  final void Function() onPause;
  final void Function() onDispose;
  final void Function() onDetach;
  final void Function() onDeactivate;

  @override
  bool get wantKeepAlive => _controller.keepViewAlive;

  @override
  void initState() {
    super.initState();
    // Share BuildContext with the controller.
    _controller.context = context;
    // Pass optional params to the controller.
    _controller.params = widget.params;
    // Set ticker provider for the controller.
    _controller.vsync = this;
    onActivate();
    _controller.onActivate();
    onInitState();
    _controller.onStart();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPostBuild();
      _controller.onReady();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onPostInitState();
    _controller.onPostStart();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        onDeactivate();
        _controller.onDeactivate();
        break;
      case AppLifecycleState.resumed:
        onActivate();
        _controller.onActivate();
        onResume();
        _controller.onResume();
        break;
      case AppLifecycleState.paused:
        onPause();
        _controller.onPause();
        break;
      case AppLifecycleState.detached:
        onDetach();
        _controller.onClose();
        break;
      default:
        break;
    }
  }

  @override
  void onVisibilityChanged(WidgetVisibility visibility) {
    switch (visibility) {
      case WidgetVisibility.VISIBLE:
        onVisible();
        _controller.onVisible();
        break;
      case WidgetVisibility.INVISIBLE:
      case WidgetVisibility.GONE:
        onHidden();
        _controller.onHidden();
        break;
    }
    super.onVisibilityChanged(visibility);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildView(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.onStop();
    onDispose();
    super.dispose();
  }
}
