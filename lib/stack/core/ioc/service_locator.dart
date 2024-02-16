import 'package:get_it/get_it.dart';

import '../logging/logger.dart';
import '../network/api_manager.dart';
import '../network/connectivity_manager.dart';
import '../popup/popup_manager.dart';

/// Global service locator instance.
/// A centric layer such as Domain must not access this object.
final locator = ServiceLocator();

/// A service locator wrapper to register and retrieve types.
class ServiceLocator {
  // Factory constructor to get the singleton object.
  factory ServiceLocator() => _singleton;

  // Internal private constructor.
  ServiceLocator._internal();

  static final ServiceLocator _singleton = ServiceLocator._internal();

  final _locator = GetIt.instance;

  /// Registers all core services along with [external] app specific ones.
  /// To be called in main before runApp.
  void initialize({void Function()? external}) {
    // Register core services.
    _registerCore();
    // Register external services.
    external?.call();
  }

  /// Retrieves registered [T] instance with an optional [key] and params.
  /// The types of params should match the types given at registration.
  T get<T extends Object>({
    String? key,
    dynamic param1,
    dynamic param2,
  }) {
    return _locator<T>(instanceName: key, param1: param1, param2: param2);
  }

  /// Handy method in place of [get] to be able to skip calling it.
  T call<T extends Object>({
    String? key,
    dynamic param1,
    dynamic param2,
  }) {
    return _locator<T>(instanceName: key, param1: param1, param2: param2);
  }

  /// Registers a [T] type as singleton with the given [instance].
  /// An optional [key] can be provided if multiple instances
  /// of the same type need to be registered.
  void registerSingleton<T extends Object>(
    T instance, {
    String? key,
  }) {
    _locator.registerSingleton<T>(instance, instanceName: key);
  }

  /// Registers a [T] type as singleton by passing a [factoryFunc] to be
  /// called on the first call of [get]. An optional [key] can be provided
  /// if multiple instances of the same type need to be registered.
  void registerLazySingleton<T extends Object>(
    T Function() factoryFunc, {
    String? key,
  }) {
    _locator.registerLazySingleton<T>(factoryFunc, instanceName: key);
  }

  /// Registers a [T] type to get a new instance on each call of [get].
  /// An optional [key] can be provided to label each registered instance.
  void registerFactory<T extends Object>(
    T Function() factoryFunc, {
    String? key,
  }) {
    _locator.registerFactory<T>(factoryFunc, instanceName: key);
  }

  /// Registers a [T] type to get a new instance on each call of [get]
  /// using [factoryFunc] that accepts up to two params to be given at retrieve.
  /// One of [P1] or [P2] can be passed as void if one parameter is enough.
  /// An optional [key] can be provided to label each registered instance.
  void registerFactoryParam<T extends Object, P1, P2>(
    T Function(P1 param1, P2 param2) factoryFunc, {
    String? key,
  }) {
    _locator.registerFactoryParam<T, P1, P2>(factoryFunc, instanceName: key);
  }

  // Helpers
  void _registerCore() {
    // Logger
    _locator.registerLazySingleton<Logger>(
      LoggerImpl.new,
    );
    // ApiManager
    _locator.registerLazySingleton<ApiManager>(
      () => ApiManagerImpl(_locator(), _locator()),
    );
    // ConnectivityManager
    _locator.registerLazySingleton<ConnectivityManager>(
      ConnectivityManagerImpl.new,
    );
    // PopupManager
    _locator.registerLazySingleton<PopupManager>(
      PopupManagerImpl.new,
    );
  }
  // - Helpers
}
