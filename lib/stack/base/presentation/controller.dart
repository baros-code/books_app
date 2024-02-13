import 'package:flutter/material.dart';

import '../../core/logging/logger.dart';
import '../../core/popup/popup_manager.dart';


abstract class Controller<TParams extends Object> {
  Controller(
    this.logger,
    this.popupManager,
  );

  /// Logger instance to be used in lifecycle events.
  @protected
  final Logger logger;

  /// PopupManager instance to be used for showing/hiding popups.
  @protected
  final PopupManager popupManager;

  /// The corresponding view's BuildContext.
  @protected
  late BuildContext context;

  /// An interface that is implemented by the corresponding view's state
  /// to be used by controllers such as AnimationController, TabController etc.
  @protected
  late TickerProvider vsync;

  /// Optional parameters that can be passed during navigation.
  @protected
  TParams? params;

  /// Indicates if the corresponding view is activated.
  @protected
  bool get isActive => _isActive;

  /// Indicates if the corresponding view is built and active.
  @protected
  bool get isReady => _isReady && _isActive;

  /// Indicates if the corresponding view is visible on screen.
  @protected
  bool get isVisible => _isVisible;

  /// Whether the corresponding view should be alive and keep its state.
  @protected
  bool get keepViewAlive => false;

  /// Called when the corresponding view is activated on start or resume.
  @protected
  @mustCallSuper
  void onActivate() {
    _isActive = true;
    _isVisible = true;
  }

  /// Called once when the corresponding view is initialized.
  @protected
  @mustCallSuper
  void onStart() {
    _isActive = true;
  }

  /// Called once when the corresponding view started and whenever
  /// the dependencies change.
  @protected
  @mustCallSuper
  void onPostStart() {
    _isActive = true;
  }

  /// Called after the corresponding view's build is finished.
  @protected
  @mustCallSuper
  void onReady() {
    _isReady = true;
  }

  /// Called when the corresponding view is visible back from pause.
  @protected
  @mustCallSuper
  void onResume() {
    _isActive = true;
  }

  /// Called when the corresponding view is visible on screen.
  @protected
  @mustCallSuper
  void onVisible() {
    _isVisible = true;
  }

  /// Called when the corresponding view is hidden on screen.
  @protected
  @mustCallSuper
  void onHidden() {
    _isVisible = false;
  }

  /// Called when the corresponding view goes invisible
  /// and running in the background.
  @protected
  @mustCallSuper
  void onPause() {
    _isActive = false;
  }

  /// Called when the corresponding view is disposed. The difference between
  /// onStop and onClose is that onClose is called when the app is detached but
  /// onStop means the corresponding view is popped from the navigation stack.
  @protected
  @mustCallSuper
  void onStop() {
    _isActive = false;
  }

  /// Called when the app is detached which usually happens when
  /// back button is pressed.
  @protected
  @mustCallSuper
  void onClose() {
    _isReady = false;
  }

  /// Called when the corresponding view is deactivated on pause or close.
  @protected
  @mustCallSuper
  void onDeactivate() {
    _isActive = false;
  }

  /// Called when back button is pressed.
  @protected
  @mustCallSuper
  Future<bool> onBackRequest() => Future.value(true);

  // Fields
  bool _isActive = false;
  bool _isReady = false;
  bool _isVisible = false;
  // - Fields
}
