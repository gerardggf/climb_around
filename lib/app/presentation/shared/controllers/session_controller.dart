import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:climb_around/app/domain/use_cases/log_out_use_case.dart';

import '../../../domain/models/user_model.dart';

final sessionControllerProvider =
    StateNotifierProvider<SessionController, UserModel?>(
  (ref) => SessionController(
    null,
    ref.read(logOutUseCaseProvider),
  ),
);

class SessionController extends StateNotifier<UserModel?> {
  SessionController(super.state, this.logOutUseCase);

  LogOutUseCase logOutUseCase;

  void setUser(UserModel user) {
    state = user;
  }

  Future<void> logOut() async {
    state = null;
    await logOutUseCase();
  }
}
