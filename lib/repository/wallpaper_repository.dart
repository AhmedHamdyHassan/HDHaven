import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/services/dio_service.dart';

class WallpaperRepository {
  final DioService _dioService = DioService();

  Future<List<WallpaperModel>> getWallpaper(int pageNumber) async {
    try {
      final List<WallpaperModel> wallpapers = [];
      final response =
          await _dioService.get('/curated?per_page=20&page=$pageNumber');
      for (int i = 0; i < response.data['photos'].length; i++) {
        wallpapers.add(
          WallpaperModel.fromJson(response.data['photos'][i]),
        );
      }
      return wallpapers;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<WallpaperModel>> searchForWallpapers(
      String searchTitle, int pageNumber) async {
    try {
      final List<WallpaperModel> wallpapers = [];
      final response = await _dioService
          .get('/search?query=$searchTitle&per_page=20&page=$pageNumber');
      for (int i = 0; i < response.data['photos'].length; i++) {
        wallpapers.add(
          WallpaperModel.fromJson(response.data['photos'][i]),
        );
      }
      return wallpapers;
    } catch (e) {
      rethrow;
    }
  }

  Future<WallpaperModel> getImage(String imageId) async {
    try {
      final response = await _dioService.get('/photos/$imageId');
      return WallpaperModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
