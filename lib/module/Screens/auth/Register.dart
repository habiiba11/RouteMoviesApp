import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routemovie/Core/Asset/AppImage.dart';
import 'package:routemovie/Core/Asset/Theme/AppColor.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        backgroundColor: AppColor.black,
        centerTitle: true,
        leading: Icon(Icons.arrow_back, color: AppColor.yellow),
        title:  Text(
            "Register",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColor.yellow,
              fontSize: 20,
            ),
          ),

      ),

      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 5,
                  horizontal: 5,
                ),
              ),
              CircleAvatar(radius: 50, child: Image.asset(AppImage.profile2)),
              SizedBox(width: 20),
              CircleAvatar(radius: 75, child: Image.asset(AppImage.profile3)),
              SizedBox(width: 20),
              CircleAvatar(radius: 50, child: Image.asset(AppImage.profile1)),
            ],
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 25, vertical: 5),
          ),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TextFormField(
                style: TextStyle(fontSize: 16, color: AppColor.white),
                decoration: InputDecoration(
                  fillColor: AppColor.gray,
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(
                      12.0,
                    ), // Adjust padding as needed
                    child: SvgPicture.asset(
                      'Asset/Svg/Name.svg', // Path to your SVG file
                      width: 24,
                      height: 24,
                      color: AppColor.white,
                    ),
                  ),
                  hintText: "Name",
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TextFormField(
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TextFormField(
                style: TextStyle(fontSize: 16, color: AppColor.white),
                decoration: InputDecoration(
                  fillColor: AppColor.gray,
                  filled: true,
                  prefixIcon: Icon(Icons.lock, color: AppColor.white),
                  suffixIcon: Icon(Icons.visibility_off, color: AppColor.white),
                  hintText: "Password",
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TextFormField(
                style: TextStyle(fontSize: 16, color: AppColor.white),
                decoration: InputDecoration(
                  fillColor: AppColor.gray,
                  filled: true,
                  prefixIcon: Icon(Icons.lock, color: AppColor.white),
                  suffixIcon: Icon(Icons.visibility_off, color: AppColor.white),
                  hintText: "Confirm Password",
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TextFormField(
                style: TextStyle(fontSize: 16, color: AppColor.white),
                decoration: InputDecoration(
                  fillColor: AppColor.gray,
                  filled: true,
                  prefixIcon: Icon(Icons.phone, color: AppColor.white),

                  hintText: "Phone Number",
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
          ),
          SizedBox(height: 12),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 130, vertical: 15),
              foregroundColor: AppColor.black,
              backgroundColor: AppColor.yellow,
              textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text("Create Account "),
          ),
          SizedBox(height: 16),
          RichText(
            text: TextSpan(
              text: 'Already Have Account ? ',
              style: TextStyle(color: AppColor.white, fontSize: 16),
              children: [
                TextSpan(
                  text: ' Login',
                  style: TextStyle(color: AppColor.yellow),
                ),
              ],
            ),
          ),
          Row(
            children: [
              CircleAvatar(

                foregroundColor: AppColor.black,
                backgroundColor: AppColor.yellow,
                child: SvgPicture.asset(
                  "Asset/Svg/LR.svg",
                  alignment: AlignmentGeometry.centerStart,
                ),
                maxRadius: 25,
                minRadius: 25,

              ),
            ],
          ),
        ],
      ),
    );
  }
}
