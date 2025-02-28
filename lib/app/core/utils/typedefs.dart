import 'package:climb_around/app/core/utils/failure/failure.dart';

import 'either/either.dart';

typedef Result<R> = Either<Failure, R>;

typedef AsyncResult<R> = Future<Either<Failure, R>>;
