import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/views/home/view/home_screen.dart';
import 'package:wallpaper_app/views/init/provider/init_provider.dart';
import 'package:wallpaper_app/views/login/view/login_screen.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<InitProvider>().checkIfUserLoggedIn(context);
    return Consumer<InitProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (value.userModel != null) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
