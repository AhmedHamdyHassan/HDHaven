import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/common/providers/user_provider.dart';
import 'package:wallpaper_app/common/routes/routes.dart';
import 'package:wallpaper_app/services/data_base_service.dart';
import 'package:wallpaper_app/utils/app_theme.dart';
import 'package:wallpaper_app/views/details/provider/details_provider.dart';
import 'package:wallpaper_app/views/favorite/provider/favorite_provider.dart';
import 'package:wallpaper_app/views/home/provider/home_provider.dart';
import 'package:wallpaper_app/views/init/provider/init_provider.dart';
import 'package:wallpaper_app/views/login/provider/login_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.instance.initDatabase();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InitProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.getTheme(),
        initialRoute: Routes.init,
        routes: Routes.routes,
      ),
    );
  }
}
