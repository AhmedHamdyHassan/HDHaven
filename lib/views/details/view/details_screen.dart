import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/utils/app_colors.dart';
import 'package:wallpaper_app/views/details/provider/details_provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.black12Color,
        elevation: 0,
      ),
      body: Consumer<DetailsProvider>(
        builder: (context, value, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.network(
                value.selectedModel.srcModel!.original!,
                fit: BoxFit.cover,
              ),

              // Overlay with a gradient to enhance visibility of text
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedIconButton(
                          icon: Icons.favorite,
                          color: value.isFavoriteWallpaper(context)
                              ? Colors.red
                              : Colors.white,
                          onPressed: () => value.favoriteWallpaper(context),
                        ),
                        RoundedIconButton(
                          icon:
                              value.isImageSaved ? Icons.done : Icons.download,
                          color: Colors.white,
                          onPressed: () async => await value.saveImage(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const RoundedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white30,
          ),
          child: Icon(
            icon,
            color: color,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
