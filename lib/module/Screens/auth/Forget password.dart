import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemovie/module/Screens/auth/manager/auth_Provider.dart';
import 'package:routemovie/routes/app_routes.dart';

import '../../../Core/Asset/Theme/AppColor.dart';

class Forgetpassword extends StatelessWidget {
  Forgetpassword({super.key});

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        backgroundColor: AppColor.black,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            child: const Icon(Icons.arrow_back, color: AppColor.yellow),
          ),
          backgroundColor: AppColor.black,
          centerTitle: true,
          title: const Text(
            "Forget Password",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.yellow,
            ),
          ),
        ),
        body: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("Asset/AppImage/forget .png"),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: TextFormField(
                        controller: authProvider.emailController,
                        validator: (value) {
                          final bool emailValid = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          ).hasMatch(value ?? "");
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter Email';
                          } else if (!emailValid) {
                            return 'Enter a Valid Email';
                          }
                          return null;
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        style: const TextStyle(fontSize: 16, color: AppColor.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.gray,
                          prefixIcon: const Icon(Icons.email, color: AppColor.white),
                          hintText: "Email",
                          hintStyle: const TextStyle(color: AppColor.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: AppColor.gray),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: AppColor.gray),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: AppColor.gray),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: AppColor.gray),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: AppColor.gray),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          authProvider.sendPasswordResetEmail();
                        }
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 135,
                          vertical: 15,
                        ),
                        foregroundColor: AppColor.black,
                        backgroundColor: AppColor.yellow,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text("Verify Email"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}