import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/common/components/app_drawer.dart';
import 'package:wallpaper_app/common/components/wallpaper_widget.dart';
import 'package:wallpaper_app/utils/app_colors.dart';
import 'package:wallpaper_app/views/favorite/provider/favorite_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteProvider>().getFavoriteImages(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.whiteColor,
        title: const Text('Favorite Images'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.firstGradientColor,
              AppColors.secondGradientColor,
            ],
          ),
        ),
        child: Consumer<FavoriteProvider>(
          builder: (context, value, child) {
            if (value.favoriteImages.isEmpty) {
              return const Center(
                child: Text(
                  'There\'s no favorite images.',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                  ),
                ),
              );
            } else {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: value.favoriteImages.length,
                    itemBuilder: (context, index) {
                      return WallpaperWidget(
                        imageUrl: value.favoriteImages[index].srcModel!.tiny!,
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
