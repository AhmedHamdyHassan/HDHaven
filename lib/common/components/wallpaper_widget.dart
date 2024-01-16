import 'package:flutter/material.dart';
import 'package:wallpaper_app/utils/app_colors.dart';

class WallpaperWidget extends StatelessWidget {
  const WallpaperWidget({
    super.key,
    required this.imageUrl,
    this.onTab,
  });

  final Function? onTab;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab != null ? () => onTab!() : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.whiteColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
