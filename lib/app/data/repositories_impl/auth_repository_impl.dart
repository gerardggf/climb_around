import 'package:climb_around/app/core/utils/extensions/string_extensions.dart';
import 'package:climb_around/app/domain/repositories/prefs_repository.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:climb_around/app/core/utils/typedefs.dart';

import 'package:climb_around/app/domain/models/user_model.dart';

import '../../core/utils/either/either.dart';
import '../../core/utils/failure/failure.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final PrefsRepository prefsRepository;

  AuthRepositoryImpl({required this.prefsRepository});

  @override
  AsyncResult<UserModel> login(String email, String password) async {
    try {
      final user = UserModel(
        name: email.substring(0, email.indexOf('@')).capitalize(),
        id: '000',
        email: email,
        creationDate: DateTime.now(),
      );
      await prefsRepository.setUserLogged(user);
      return Either.right(user);
    } catch (e) {
      if (kDebugMode) print(e.toString());
      return Either.left(
        Failure('Unknown error'),
      );
    }
  }

  @override
  Future<bool> logOut() async {
    try {
      await prefsRepository.setUserLogged(null);
      return true;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      return false;
    }
  }

  @override
  Future<UserModel?> isAuthenticated() async {
    //(unnecesary async function but just to see what normal operation would be like)
    final user = prefsRepository.userLogged;
    return user;
  }
}
