import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routemovie/Core/Asset/AppLogo.dart';

import '../../../Core/Asset/Theme/AppColor.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,

      body: Expanded(
        child: Column(
          children: [
            SafeArea(child: Center(child: Image.asset(Applogo.logo))),
            SizedBox(height: 60),
            Container(
              child: TextFormField(
                style: TextStyle(fontSize: 16, color: AppColor.white),
                decoration: InputDecoration(
                  fillColor:AppColor.gray,
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
                style: TextStyle(fontSize: 16, color: AppColor.white),
                decoration: InputDecoration(
                  fillColor:AppColor.gray,
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
                Text(
                  "Forget Password ?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.yellow,
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
            SizedBox(height: 16,),

              RichText(
                text: TextSpan(
                  text: 'Don’t Have Account ',
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: ' Create One',
                      style: TextStyle(
                        color: AppColor.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 16),
            Text("----------------OR------------------",
            style: TextStyle(
              fontSize: 18,
              color: AppColor.yellow,
            ),),
            SizedBox(height: 16),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
              iconAlignment:IconAlignment.start,
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
    );
  }
}
