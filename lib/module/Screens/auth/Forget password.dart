import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemovie/module/Screens/auth/manager/auth%20_Provider.dart';
import 'package:routemovie/routes/app_routes.dart';

import '../../../Core/Asset/Theme/AppColor.dart';

class Forgetpassword extends StatelessWidget {
  Forgetpassword({super.key});
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Scaffold(
          backgroundColor: AppColor.black,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              child: Icon(Icons.arrow_back, color: AppColor.yellow),
            ),
            backgroundColor: AppColor.black,
            centerTitle: true,
            title: Text(
              "Forget Password",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColor.yellow,
              ),
            ),
          ),
          body: Consumer<AuthProvider>(
            builder: (context, Provider, child) {
              return Form(
                key: formkey,
                child: Column(
                  children: [
                    Image.asset("Asset/AppImage/forget .png"),
                    SizedBox(height: 25),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: TextFormField(
                        controller: Provider.emailController,
                        validator: (value) {
                          final bool emailvalid = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          ).hasMatch(value ?? "");
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter Email';
                          } else if (!emailvalid) {
                            return 'Enter a Valid Email';
                          } else {
                            return null;
                          }
                        },
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        style: TextStyle(fontSize: 16, color: AppColor.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.gray,
                          prefixIcon: Icon(Icons.email, color: AppColor.white),

                          hintText: "Email",
                          hintStyle: TextStyle(color: AppColor.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: AppColor.gray),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: AppColor.gray),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: AppColor.gray),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: AppColor.gray),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: AppColor.gray),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 135,
                          vertical: 15,
                        ),
                        foregroundColor: AppColor.black,
                        backgroundColor: AppColor.yellow,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text("Verify Email "),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
