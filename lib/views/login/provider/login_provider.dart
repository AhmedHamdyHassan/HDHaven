// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/common/enums/enums.dart';
import 'package:wallpaper_app/common/providers/user_provider.dart';
import 'package:wallpaper_app/common/routes/routes.dart';
import 'package:wallpaper_app/models/user_model.dart';
import 'package:wallpaper_app/services/data_base_service.dart';
import 'package:wallpaper_app/services/firebase_auth_service.dart';
import 'package:wallpaper_app/services/shared_preference_service.dart';

class LoginProvider extends ChangeNotifier {
  LoginStateEnum _loginStateEnum = LoginStateEnum.LOGIN;
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  FirebaseAuthService firebaseAuthService = FirebaseAuthService.instance;
  final DatabaseService _databaseService = DatabaseService.instance;
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService.instance;
  bool isPasswordVisible = false;
  bool isLoading = false;
  void toggleLoginState() {
    if (_loginStateEnum == LoginStateEnum.LOGIN) {
      _loginStateEnum = LoginStateEnum.RIGESTER;
    } else {
      _loginStateEnum = LoginStateEnum.LOGIN;
    }
    notifyListeners();
  }

  void togglePasswordVisibilityState() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  bool isInLoginState() {
    return _loginStateEnum == LoginStateEnum.LOGIN;
  }

  void customizePhoneNumberIntoUSAStyle(String phoneNumber) {
    if (phoneNumber.isNotEmpty) {
      if (phoneNumber[0] != '+') {
        phoneNumberController.text = '+1 $phoneNumber';
        return;
      } else if (phoneNumber.length > 1 && phoneNumber[1] != '1') {
        phoneNumberController.text = '+1 ${phoneNumber.substring(1)}';
        return;
      }
    }
  }

  Future<void> login(BuildContext context) async {
    if (formGlobalKey.currentState!.validate()) {
      try {
        isLoading = true;
        notifyListeners();
        final user = await firebaseAuthService.signInWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
        if (user != null) {
          _sharedPreferencesService.storeUserId(user.uid);
          final userProvider = context.read<UserProvider>();
          userProvider.userModel = await _databaseService.getUser(user.uid);
          isLoading = false;
          notifyListeners();
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.home,
            (route) => false,
          );
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> registerUser(BuildContext context) async {
    try {
      if (formGlobalKey.currentState!.validate()) {
        isLoading = true;
        notifyListeners();
        final user = await firebaseAuthService.registerWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
        if (user != null) {
          _sharedPreferencesService.storeUserId(user.uid);
          final userProvider = context.read<UserProvider>();
          userProvider.userModel = UserModel(
            firstNameController.text,
            lastNameController.text,
            emailController.text,
            phoneNumberController.text,
            [],
          );
          _databaseService.insertUser(
            userId: user.uid,
            model: userProvider.userModel!,
          );
          isLoading = false;
          notifyListeners();
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.home,
            (route) => false,
          );
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
