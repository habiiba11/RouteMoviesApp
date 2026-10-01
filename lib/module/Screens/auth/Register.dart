import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:routemovie/Core/Asset/AppImage.dart';
import 'package:routemovie/Core/Asset/Theme/AppColor.dart';
import 'package:routemovie/module/Screens/auth/manager/auth_Provider.dart';
import 'package:routemovie/routes/app_routes.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  InputDecoration _fieldDecoration({
    required String hint,
    required Widget prefixIcon,
    Widget? suffixIcon,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: AppColor.gray),
    );
    return InputDecoration(
      fillColor: AppColor.gray,
      filled: true,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hint,
      hintStyle: TextStyle(color: AppColor.white),
      focusedBorder: border,
      errorBorder: border,
      enabledBorder: border,
      focusedErrorBorder: border,
      disabledBorder: border,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        backgroundColor: AppColor.black,
        appBar: AppBar(
          backgroundColor: AppColor.black,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            child: Icon(Icons.arrow_back, color: AppColor.yellow),
          ),
          title: Text(
            "Register",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColor.yellow,
              fontSize: 20,
            ),
          ),
        ),
        body: Consumer<AuthProvider>(
          builder: (BuildContext context, AuthProvider authProvider, child) {
            return Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 5),
                        CircleAvatar(
                          radius: 50,
                          child: Image.asset(AppImage.profile2),
                        ),
                        const SizedBox(width: 20),
                        CircleAvatar(
                          radius: 75,
                          child: Image.asset(AppImage.profile3),
                        ),
                        const SizedBox(width: 20),
                        CircleAvatar(
                          radius: 50,
                          child: Image.asset(AppImage.profile1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Avatar",
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                        ),
                      ),
                    ),

                    // Name
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: authProvider.nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter Name';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 16, color: AppColor.white),
                        decoration: _fieldDecoration(
                          hint: "Name",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              'Asset/Svg/Name.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Email
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: authProvider.emailController,
                        keyboardType: TextInputType.emailAddress,
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
                        style: TextStyle(fontSize: 16, color: AppColor.white),
                        decoration: _fieldDecoration(
                          hint: "Email",
                          prefixIcon: Icon(Icons.email, color: AppColor.white),
                        ),
                      ),
                    ),

                    // Password
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: authProvider.passwordController,
                        obscureText: !isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Password';
                          } else if (value.length < 6) {
                            return 'Enter more than 6 characters';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 16, color: AppColor.white),
                        decoration: _fieldDecoration(
                          hint: "Password",
                          prefixIcon: Icon(Icons.lock, color: AppColor.white),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Confirm Password
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: !isConfirmPasswordVisible,
                        validator: (value) {
                          if (value != authProvider.passwordController.text) {
                            return 'Password not matched';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 16, color: AppColor.white),
                        decoration: _fieldDecoration(
                          hint: "Confirm Password",
                          prefixIcon: Icon(Icons.lock, color: AppColor.white),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                !isConfirmPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Phone Number
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter a Number';
                          } else if (value.trim().length != 11) {
                            return 'Enter a valid number';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 16, color: AppColor.white),
                        decoration: _fieldDecoration(
                          hint: "Phone Number",
                          prefixIcon: Icon(Icons.phone, color: AppColor.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          authProvider.createAccount();
                        }
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 130,
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
                      child: const Text("Create Account"),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have Account ? ",
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.login);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: AppColor.yellow,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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