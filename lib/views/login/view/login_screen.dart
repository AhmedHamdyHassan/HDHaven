import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/common/functions/functions.dart';
import 'package:wallpaper_app/utils/app_colors.dart';
import 'package:wallpaper_app/views/login/provider/login_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Consumer<LoginProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              );
            } else {
              return Form(
                key: value.formGlobalKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Welcome to HD Haven',
                            style: TextStyle(fontSize: 30),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 10,
                            ),
                            child: const Text(
                              'Here you will find a wonderful wallpapers',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Visibility(
                            visible: !value.isInLoginState(),
                            child: TextFormField(
                              controller: value.firstNameController,
                              validator: (firstName) =>
                                  Functions.nameValidation(firstName!),
                              decoration: const InputDecoration(
                                hintText: 'First Name',
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !value.isInLoginState(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                controller: value.lastNameController,
                                validator: (lastName) =>
                                    Functions.nameValidation(lastName!),
                                decoration: const InputDecoration(
                                  hintText: 'Last Name',
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: value.emailController,
                            validator: (email) =>
                                Functions.emailValidation(email!),
                            decoration: const InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: value.passwordController,
                              validator: (password) =>
                                  Functions.passwordValidation(password!),
                              obscureText: !value.isPasswordVisible,
                              obscuringCharacter: '*',
                              decoration: InputDecoration(
                                hintText: 'Password',
                                suffixIcon: InkWell(
                                  onTap: () =>
                                      value.togglePasswordVisibilityState(),
                                  child: value.isPasswordVisible
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !value.isInLoginState(),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                validator: (phoneNumber) =>
                                    Functions.phoneNumberValidation(
                                        phoneNumber!),
                                controller: value.phoneNumberController,
                                onChanged: (phoneNumber) =>
                                    value.customizePhoneNumberIntoUSAStyle(
                                  phoneNumber,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Phone number',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: OutlinedButton(
                              onPressed: () async => value.isInLoginState()
                                  ? await value.login(context)
                                  : await value.registerUser(context),
                              child: Text(
                                value.isInLoginState() ? 'Sign in' : 'Sign up',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Or if you ${value.isInLoginState() ? 'aren\'t' : 'are'} registered press ',
                              ),
                              GestureDetector(
                                onTap: () => value.toggleLoginState(),
                                child: Text(
                                  value.isInLoginState() ? 'Register' : 'Login',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
