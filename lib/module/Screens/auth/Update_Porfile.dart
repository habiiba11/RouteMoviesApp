import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routemovie/Core/Asset/AppImage.dart';
import 'package:routemovie/Core/Asset/Theme/AppColor.dart';

class UpdatePorfile extends StatelessWidget {
  const UpdatePorfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        backgroundColor: AppColor.black,
        appBar: AppBar(
          backgroundColor: AppColor.black,
          centerTitle:true,
          leading: Icon(Icons.arrow_back_outlined, color: AppColor.yellow),
          title:
             Text(
              "Pick Avatar",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColor.yellow,
              ),
            ),


        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 80,
                child: Image.asset(AppImage.profile3),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                child: TextFormField(

                  style: TextStyle(fontSize: 16, color: AppColor.white),
                  decoration: InputDecoration(
                    fillColor: AppColor.gray,
                    filled: true,
                    prefixIcon: Icon(Icons.person, color: AppColor.white),

                    hintText: "John Safwat",
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                child: TextFormField(
                  style: TextStyle(fontSize: 16, color: AppColor.white),
                  decoration: InputDecoration(
                    fillColor: AppColor.gray,
                    filled: true,
                    prefixIcon: Icon(Icons.phone, color: AppColor.white),

                    hintText: "01200000000",
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "  Reset Password",
                  style: TextStyle(
                    color: AppColor.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 310,),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 15,
                  horizontal: 120,
                ),

                foregroundColor: AppColor.white,
                backgroundColor: AppColor.red,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColor.white,
                ),
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
              ),
              child: Text("Delete Account"),
            ),
            SizedBox(height: 15,),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 15,
                  horizontal: 130,
                ),
                foregroundColor: AppColor.black,
                backgroundColor: AppColor.yellow,
                textStyle: TextStyle(

                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColor.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
              ),
              child: Text("Update Data"),
            ),
          ],
        ),
      ),
    );
  }
}
