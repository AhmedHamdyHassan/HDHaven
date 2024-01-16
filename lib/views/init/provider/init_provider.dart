// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/common/providers/user_provider.dart';
import 'package:wallpaper_app/models/user_model.dart';
import 'package:wallpaper_app/services/data_base_service.dart';
import 'package:wallpaper_app/services/shared_preference_service.dart';

class InitProvider extends ChangeNotifier {
  bool isLoading = true;
  UserModel? userModel;
  final SharedPreferencesService _sharedPreferencesManager =
      SharedPreferencesService.instance;
  final DatabaseService _databaseService = DatabaseService.instance;
  Future<void> checkIfUserLoggedIn(BuildContext context) async {
    String? userId = await _sharedPreferencesManager.getUserId();
    if (userId != null && userId != '') {
      userModel = await _databaseService.getUser(userId);
      context.read<UserProvider>().userModel = userModel;
    }
    isLoading = false;
    notifyListeners();
  }
}
