import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:routemovie/Core/Asset/AppLogo.dart';
import 'package:routemovie/routes/app_routes.dart';

import '../../../Core/Asset/Theme/AppColor.dart';
import 'manager/auth _Provider.dart';

class Login extends StatelessWidget {
  Login({super.key});
  GlobalKey<FormState>Formkey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,

      body: Expanded(
        child: Form(
          key: Formkey,
          child: ChangeNotifierProvider(
            create:(context) => AuthProvider(),
            child: Column(
              children: [
                SafeArea(child: Center(child: Image.asset(Applogo.logo))),
                SizedBox(height: 60),
                Container(
                  child: TextFormField(

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
                    style: TextStyle(fontSize: 16, color: AppColor.white),
                    decoration: InputDecoration(
                      fillColor: AppColor.gray,
                      filled: true,
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
                Container(
                  child: TextFormField(

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password';
                      } else if (value.length < 6) {
                        return 'Enter more than Char Or Numbers';
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    style: TextStyle(fontSize: 16, color: AppColor.white),
                    decoration: InputDecoration(
                      fillColor: AppColor.gray,
                      filled: true,
                      prefixIcon: Icon(Icons.lock, color: AppColor.white),
                      suffixIcon: Icon(Icons.visibility_off, color: AppColor.white),
                      hintText: "password",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(onTap: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.forgetPassword);
                    },
                      child: Text(
                        "Forget Password ?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.yellow,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 170, vertical: 15),
                    foregroundColor: AppColor.black,
                    backgroundColor: AppColor.yellow,
                    textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text("login "),
                ),
                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t Have Account ?  ",
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(onTap: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.register);
                    },
                      child: Text(
                        " Create One",
                        style: TextStyle(
                          color: AppColor.yellow,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(width: 80,),
                    Container(
                      height: 2,
                      width:80,
                      color: AppColor.yellow,
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'OR',
                        style: TextStyle(

                          color: AppColor.yellow,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      width:80,
                      color: AppColor.yellow,
                    ),

                  ],
                ),
                SizedBox(height: 16),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    iconAlignment: IconAlignment.start,
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                    foregroundColor: AppColor.black,
                    backgroundColor: AppColor.yellow,
                    textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text("Login With Google"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
