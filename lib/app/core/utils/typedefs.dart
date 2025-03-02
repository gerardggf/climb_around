import 'package:climb_around/app/core/utils/failure/failure.dart';

import 'either/either.dart';

///Shortcut for [Either]
typedef Result<R> = Either<Failure, R>;

///Shortcut for async [Either]
typedef AsyncResult<R> = Future<Either<Failure, R>>;
