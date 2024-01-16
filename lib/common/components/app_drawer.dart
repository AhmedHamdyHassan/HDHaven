import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/common/functions/functions.dart';
import 'package:wallpaper_app/common/providers/user_provider.dart';
import 'package:wallpaper_app/common/routes/routes.dart';
import 'package:wallpaper_app/utils/app_colors.dart';
import 'package:wallpaper_app/views/home/provider/home_provider.dart';

String currentScreen = Routes.home;

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return Drawer(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.firstGradientColor,
                  AppColors.secondGradientColor,
                ],
              ),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          'assets/images/profile_defualt_image.png',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${value.userModel!.firstName} ${value.userModel!.lastName}',
                        style: const TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${value.userModel!.email}',
                        style: const TextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: currentScreen == Routes.home
                        ? AppColors.blueColor
                        : AppColors.whiteColor,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: currentScreen == Routes.home
                          ? AppColors.blueColor
                          : AppColors.whiteColor,
                    ),
                  ),
                  onTap: () {
                    if (currentScreen != Routes.home) {
                      currentScreen = Routes.home;
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.home,
                        (route) => false,
                      );
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: currentScreen == Routes.favorite
                        ? AppColors.blueColor
                        : AppColors.whiteColor,
                  ),
                  title: Text(
                    'Favorite',
                    style: TextStyle(
                      color: currentScreen == Routes.favorite
                          ? AppColors.blueColor
                          : AppColors.whiteColor,
                    ),
                  ),
                  onTap: () {
                    if (currentScreen != Routes.favorite) {
                      currentScreen = Routes.favorite;
                      context.read<HomeProvider>().resetData();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.favorite,
                        (route) => false,
                      );
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: AppColors.whiteColor,
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () async {
                    Functions.showLogoutConfirmationDialog(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
