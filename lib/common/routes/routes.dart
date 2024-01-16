import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/details/view/details_screen.dart';
import 'package:wallpaper_app/views/favorite/view/favorite_screen.dart';
import 'package:wallpaper_app/views/home/view/home_screen.dart';
import 'package:wallpaper_app/views/init/view/init_screen.dart';
import 'package:wallpaper_app/views/login/view/login_screen.dart';

class Routes {
  static const String init = '/';
  static const String home = 'home';
  static const String details = '/details';
  static const String favorite = '/favorite';
  static const String login = '/login';

  static Map<String, WidgetBuilder> get routes {
    return {
      init: (context) => const InitScreen(),
      home: (context) => const HomeScreen(),
      details: (context) => const DetailsScreen(),
      favorite: (context) => const FavoriteScreen(),
      login: (context) => const LoginScreen(),
    };
  }
}
