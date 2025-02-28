import 'package:freezed_annotation/freezed_annotation.dart';

part 'either.freezed.dart';

@freezed
class Either<L, R> with _$Either<L, R> {
  /// Error
  factory Either.left(L value) = Left;

  /// Success
  factory Either.right(R value) = Right;
}
