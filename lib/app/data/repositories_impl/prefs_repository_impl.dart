import 'dart:convert';

import 'package:climb_around/app/domain/enums/prefs_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/user_model.dart';
import '../../domain/repositories/prefs_repository.dart';

class PrefsRepositoryImpl implements PrefsRepository {
  PrefsRepositoryImpl(this._sharedPrefs);

  final SharedPreferences _sharedPrefs;

  @override
  bool get isDarkMode =>
      _sharedPrefs.getBool(PrefsEnum.isDarkMode.name) ?? false;

  @override
  Future<bool> setThemeMode(bool value) async {
    return await _sharedPrefs.setBool(
      PrefsEnum.isDarkMode.name,
      value,
    );
  }

  @override
  UserModel? get userLogged {
    try {
      final userString = _sharedPrefs.getString(PrefsEnum.userLogged.name);
      if (userString == null) return null;
      final decodedUser = jsonDecode(userString) as Map<String, dynamic>;
      return UserModel.fromJson(decodedUser);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> setUserLogged(UserModel? user) async {
    if (user == null) {
      return await _sharedPrefs.remove(PrefsEnum.userLogged.name);
    }
    final userString = jsonEncode(user.toJson());
    return await _sharedPrefs.setString(
      PrefsEnum.userLogged.name,
      userString,
    );
  }
}
