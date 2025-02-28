import 'package:climb_around/app/domain/repositories/prefs_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:climb_around/app/core/utils/typedefs.dart';
import 'package:climb_around/app/data/repositories_impl/auth_repository_impl.dart';
import 'package:climb_around/app/domain/models/user_model.dart';

final authRepoProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    prefsRepository: ref.read(prefsRepoProvider),
  ),
);

abstract class AuthRepository {
  AsyncResult<UserModel> login(String email, String password);

  /// If the user is authenticated, returns the user, otherwise returns null
  Future<UserModel?> isAuthenticated();

  Future<bool> logOut();
}
