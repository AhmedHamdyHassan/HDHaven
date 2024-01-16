import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/common/providers/user_provider.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/repository/wallpaper_repository.dart';

class FavoriteProvider extends ChangeNotifier {
  List<WallpaperModel> favoriteImages = [];
  final WallpaperRepository _repository = WallpaperRepository();
  Future<void> getFavoriteImages(BuildContext context) async {
    favoriteImages = [];
    final userModel = context.read<UserProvider>().userModel;
    if (userModel!.favoriteImages != null &&
        userModel.favoriteImages!.isNotEmpty) {
      for (String id in userModel.favoriteImages!) {
        if (id != '') {
          favoriteImages.add(await _repository.getImage(id));
        }
      }
    }
    if (favoriteImages.isNotEmpty) {
      notifyListeners();
    }
  }
}
