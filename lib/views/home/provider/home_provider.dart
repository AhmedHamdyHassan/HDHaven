import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/common/routes/routes.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/views/details/provider/details_provider.dart';

class HomeProvider extends ChangeNotifier {
  final WallpaperRepository _repository = WallpaperRepository();
  List<WallpaperModel> wallpapers = [];
  bool isLoading = true;
  bool showLoadingIndecatorOnCenter = true;
  ScrollController wallpaperScrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  int _page = 1;
  Future<void> getWallpapers() async {
    try {
      if (!showLoadingIndecatorOnCenter) {
        isLoading = true;
        notifyListeners();
      }
      wallpapers.addAll(
        await _repository.getWallpaper(_page),
      );
      isLoading = false;
      showLoadingIndecatorOnCenter = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> searchForWallpapers() async {
    try {
      if (!showLoadingIndecatorOnCenter) {
        isLoading = true;
        notifyListeners();
      }
      wallpapers.addAll(
          await _repository.searchForWallpapers(searchController.text, _page));
      isLoading = false;
      showLoadingIndecatorOnCenter = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> onSubmitData() async {
    _page = 1;
    showLoadingIndecatorOnCenter = true;
    notifyListeners();
    wallpapers = [];
    await searchForWallpapers();
  }

  void clearSearchResults() async {
    _page = 1;
    showLoadingIndecatorOnCenter = true;
    searchController.text = '';
    notifyListeners();
    wallpapers = [];
    await getWallpapers();
  }

  void setSelectedWallpaper(
      BuildContext context, WallpaperModel wallpaperModel) {
    context.read<DetailsProvider>().selectedModel = wallpaperModel;
    Navigator.pushNamed(context, Routes.details);
  }

  void resetData() {
    showLoadingIndecatorOnCenter = true;
    wallpapers = [];
    wallpaperScrollController = ScrollController();
  }

  Future<void> initData() async {
    await getWallpapers();
    wallpaperScrollController.addListener(() async {
      if (wallpaperScrollController.position.pixels ==
          wallpaperScrollController.position.maxScrollExtent) {
        _page++;
        if (searchController.text != '') {
          await searchForWallpapers();
        } else {
          await getWallpapers();
        }
      }
    });
  }
}
