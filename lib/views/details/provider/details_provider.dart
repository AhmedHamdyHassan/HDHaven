// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/common/functions/functions.dart';
import 'package:wallpaper_app/common/providers/user_provider.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/services/data_base_service.dart';
import 'package:wallpaper_app/services/shared_preference_service.dart';

class DetailsProvider extends ChangeNotifier {
  late WallpaperModel selectedModel;
  final DatabaseService _databaseService = DatabaseService.instance;
  final SharedPreferencesService _preferencesService =
      SharedPreferencesService.instance;
  bool isImageSaved = false;

  bool isFavoriteWallpaper(BuildContext context) {
    final userModel = context.read<UserProvider>().userModel;
    bool isFavorite = false;
    if (userModel!.favoriteImages != null ||
        userModel.favoriteImages!.isEmpty) {
      for (String id in userModel.favoriteImages!) {
        if (id == '${selectedModel.id}') {
          isFavorite = true;
          break;
        }
      }
    } else {
      isFavorite = false;
    }
    return isFavorite;
  }

  Future<void> saveImage() async {
    try {
      await Functions.downloadAndSaveImage(
          selectedModel.srcModel!.large2x!, '${selectedModel.id}');
      isImageSaved = true;
      notifyListeners();
      await Future.delayed(
        const Duration(seconds: 2),
      );
      isImageSaved = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> favoriteWallpaper(BuildContext context) async {
    final userProvider = context.read<UserProvider>();
    String? userId = await _preferencesService.getUserId();
    if (!isFavoriteWallpaper(context)) {
      userProvider.userModel!.favoriteImages!.add(
        '${selectedModel.id}',
      );
    } else {
      userProvider.userModel!.favoriteImages!.remove('${selectedModel.id}');
    }
    await _databaseService.updateUser(
      userId: userId!,
      updatedData: userProvider.userModel!,
    );
    notifyListeners();
  }
}
