import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../common/models/api/api_cancel_token.dart';
import '../../common/models/failure.dart';
import '../../common/models/result.dart';
import '../../core/logging/logger.dart';

abstract class UseCase<TInput, TOutput extends Result<dynamic, Failure>, TEvent>
    extends _UseCaseBase<TEvent> {
  UseCase(super.logger);

  final cancelToken = ApiCancelToken();

  bool _isRunning = false;

  @override
  Future<void> stop() async {
    if (_isRunning) cancelToken.cancel();
    super.stop();
  }
 
  /// Executes use case with the given [params] and
  /// returns a FutureOr of a [TOutput] instance.
  @nonVirtual
  FutureOr<TOutput> call({TInput? params}) async {
    _isRunning = true;
    final result = await execute(params: params);
    cancelToken.refresh();
    _isRunning = false;
    return result;
  }

  /// Use case execution logic to be overridden.
  FutureOr<TOutput> execute({TInput? params});
}

abstract class StreamUseCase<TInput, TOutput extends Result<dynamic, Failure>,
    TEvent> extends _UseCaseBase<TEvent> {
  StreamUseCase(super.logger);

  /// Executes use case with the given [params] and
  /// returns a Stream of [TOutput] instances.
  Stream<TOutput> call({TInput? params});
}

/// Private base class for use cases.
abstract class _UseCaseBase<TEvent> {
  _UseCaseBase(this.logger);

  final Logger logger;

  final _eventController = StreamController<TEvent>();

  /// Receives events of type [TEvent] to inform receiver
  /// when an intermediary update occurs during use case execution.
  Stream<TEvent> get onEvent => _eventController.stream;

  /// Publishes the given [event] to the subscribers of [onEvent].
  @protected
  void publish(TEvent event) {
    if (_eventController.hasListener) _eventController.add(event);
  }

  /// Useful to be overriden to stop a long running execution.
  @mustCallSuper
  Future<void> stop() async {
    if (_eventController.hasListener) {
      await _eventController.close();
    }
  }
}
