import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'failure.dart';

/// A union type to be used in anywhere possible. Basically, [TValue] and
/// [TError] types can be provided as desired. Then, [value] or [error] can be
/// set through [Result.success] or [Result.failure] factory constuctors.
///
/// ```dart
/// Result<Foo, Failure> foo() {
///   return Result.success(value: Foo());
///   or
///   return Result.failure(Failure(message: 'Error occurred!'));
/// }
/// ```
///
/// Generic type parameters can be fully ignored to be able to omit [value]
/// property at initialization. In this case, checking [isSuccessful] property
/// should be enough to validate success.
///
/// Example:
///
/// ```dart
/// Result foo() {
///   return Result.success();
/// }
///
/// void main() {
///   final result = foo();
///   print(result.isSuccessful);
/// }
/// ```
///
/// This will print true even though [value] is not provided.
///
/// But still, if bool is needed as the return type (because maybe 'false' is
/// also a success result for you), pass it to [TValue] generic type parameter
/// just like the other types.
class Result<TValue extends Object, TError extends Failure> extends Equatable {
  /// Prefer [Result.success] or [Result.failure] instead of this constructor.

  /// Indicates if the result is successful or not.
  final bool isSuccessful;

  /// Value object to be used when [isSuccessful] is true.
  final TValue? value;

  /// Error object to be used when [isSuccessful] is false.
  final TError? error;

  @protected
  const Result.internal({
    this.value,
    this.error,
  })  : assert(
          TValue == Object || value != null || error != null,
          'Either value or error should be provided or value to be omitted!',
        ),
        assert(
          value == null || error == null,
          'Both value and error cannot be provided!',
        ),
        isSuccessful = (TValue == Object && error == null) || value != null;

  factory Result.success({TValue? value}) => Result.internal(value: value);

  factory Result.failure(TError? error) => Result.internal(error: error);

  @override
  List<Object?> get props => [isSuccessful, value, error];
}
