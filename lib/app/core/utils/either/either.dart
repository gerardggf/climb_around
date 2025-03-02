import 'package:freezed_annotation/freezed_annotation.dart';

part 'either.freezed.dart';

@freezed

/// Used to return the expected value or an error
/// - Left: Error
/// - Right: Success
class Either<L, R> with _$Either<L, R> {
  /// Error
  factory Either.left(L value) = Left;

  /// Success
  factory Either.right(R value) = Right;
}
