// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/common/components/app_drawer.dart';
import 'package:wallpaper_app/common/routes/routes.dart';
import 'package:wallpaper_app/services/firebase_auth_service.dart';
import 'package:wallpaper_app/services/shared_preference_service.dart';
import 'package:wallpaper_app/views/home/provider/home_provider.dart';

class Functions {
  static bool _containsSpecialCharacter(String text) {
    RegExp specialCharRegex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
    return specialCharRegex.hasMatch(text);
  }

  static bool _containsNumber(String text) {
    RegExp numberRegex = RegExp(r'\d');
    return numberRegex.hasMatch(text);
  }

  static bool _containsUpperCase(String text) {
    return text.runes.any((rune) =>
        String.fromCharCode(rune).toUpperCase() != String.fromCharCode(rune));
  }

  static bool _containsLowerCase(String text) {
    return text.runes.any((rune) =>
        String.fromCharCode(rune).toLowerCase() != String.fromCharCode(rune));
  }

  static String? nameValidation(String name) {
    if (name.trim().isEmpty) {
      return 'This field is required!';
    } else if (_containsSpecialCharacter(name)) {
      return 'Name field can\'t have a special character!';
    } else if (_containsNumber(name)) {
      return 'Name field can\'t have a number!';
    } else {
      return null;
    }
  }

  static String? emailValidation(String email) {
    if (email.trim().isEmpty) {
      return 'This field is required!';
    } else if (!email.contains('@') ||
        !email.contains('.com') ||
        email[email.indexOf('@') + 1] == '.') {
      return 'Invalid email!';
    } else {
      return null;
    }
  }

  static String? passwordValidation(String password) {
    if (password.trim().isEmpty) {
      return 'This field is required!';
    } else if (password.length < 8) {
      return 'Password length should be at least 8 characters';
    } else if (!_containsSpecialCharacter(password)) {
      return 'Password should have at least a special character!';
    } else if (!_containsNumber(password)) {
      return 'Password should have at least one number';
    } else if (!_containsLowerCase(password)) {
      return 'Password should have at least a lower case character!';
    } else if (!_containsUpperCase(password)) {
      return 'Password should have at least a upper case character!';
    } else {
      return null;
    }
  }

  static String? phoneNumberValidation(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return 'This field is required!';
    }
    String number = phoneNumber.substring(3);
    if (_containsSpecialCharacter(number)) {
      return 'Phone number field can\'t have a special character!';
    } else if (number.length < 10) {
      return 'Please enter a valid number in (USA)!';
    } else {
      return null;
    }
  }

  static Future<void> downloadAndSaveImage(String imageUrl, String name) async {
    try {
      Dio dio = Dio();
      Response<Uint8List> response = await dio.get<Uint8List>(
        imageUrl,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      Uint8List imageBytes = response.data!;
      String filePath = '/storage/emulated/0/Download/$name.jpg';
      await File(filePath).writeAsBytes(imageBytes);
    } catch (error) {
      rethrow;
    }
  }

  static void showLogoutConfirmationDialog(BuildContext context) {
    SharedPreferencesService sharedPreferencesService =
        SharedPreferencesService.instance;
    FirebaseAuthService firebaseAuthService = FirebaseAuthService.instance;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await sharedPreferencesService.storeUserId('');
                await firebaseAuthService.signOut();
                context.read<HomeProvider>().resetData();
                currentScreen = Routes.home;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.login,
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
