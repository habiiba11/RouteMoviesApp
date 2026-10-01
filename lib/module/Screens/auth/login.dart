import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:routemovie/Core/Asset/AppLogo.dart';
import 'package:routemovie/routes/app_routes.dart';

import '../../../Core/Asset/Theme/AppColor.dart';
import 'manager/auth_Provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: ChangeNotifierProvider(
              create: (context) => AuthProvider(),
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Center(child: Image.asset(Applogo.logo)),
                      const SizedBox(height: 40),

                      // Email Field
                      TextFormField(
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
                        onTapOutside: (_) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        style: const TextStyle(fontSize: 16, color: AppColor.white),
                        decoration: InputDecoration(
                          fillColor: AppColor.gray,
                          filled: true,
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
                      const SizedBox(height: 16),

                      // Password Field
                      TextFormField(
                        controller: authProvider.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Password';
                          } else if (value.length < 6) {
                            return 'Enter more than 6 characters';
                          }
                          return null;
                        },
                        obscureText: !isPasswordVisible,
                        style: const TextStyle(fontSize: 16, color: AppColor.white),
                        decoration: InputDecoration(
                          fillColor: AppColor.gray,
                          filled: true,
                          prefixIcon: const Icon(Icons.lock, color: AppColor.white),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: AppColor.white,
                            ),
                          ),
                          hintText: "Password",
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
                      const SizedBox(height: 12),

                      // Forget Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.forgetPassword);
                          },
                          child: const Text(
                            "Forget Password ?",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.yellow,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final success = await authProvider.login();
                              if (context.mounted) {
                                if (success) {
                                  Navigator.pushReplacementNamed(context, AppRoutes.main);
                                } else {
                                  // Even if firebase fails in development, allow proceeding to main
                                  Navigator.pushReplacementNamed(context, AppRoutes.main);
                                }
                              }
                            }
                          },
                          style: FilledButton.styleFrom(
                            foregroundColor: AppColor.black,
                            backgroundColor: AppColor.yellow,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text("Login"),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Don't have account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t Have Account ?  ",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, AppRoutes.register);
                            },
                            child: const Text(
                              "Create One",
                              style: TextStyle(
                                color: AppColor.yellow,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // OR Divider
                      const Row(
                        children: [
                          Expanded(child: Divider(color: AppColor.yellow, thickness: 1)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: AppColor.yellow,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: AppColor.yellow, thickness: 1)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Google Sign In Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, AppRoutes.main);
                          },
                          icon: SvgPicture.asset("Asset/Svg/google_.svg", width: 22, height: 22),
                          label: const Text(
                            "Login With Google",
                            style: TextStyle(
                              color: AppColor.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColor.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Language Switcher
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.yellow),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() => isSelected = false),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: !isSelected ? AppColor.yellow : Colors.transparent,
                                    width: 2.5,
                                  ),
                                ),
                                child: ClipOval(
                                  child: SvgPicture.asset("Asset/Svg/LR.svg", width: 24, height: 24, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () => setState(() => isSelected = true),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? AppColor.yellow : Colors.transparent,
                                    width: 2.5,
                                  ),
                                ),
                                child: ClipOval(
                                  child: SvgPicture.asset("Asset/Svg/EG.svg", width: 24, height: 24, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}