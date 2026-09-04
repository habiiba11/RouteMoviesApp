import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Core/Asset/Theme/AppColor.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        backgroundColor:AppColor.black,
        appBar: AppBar(leading: Icon(Icons.arrow_back,color: AppColor.yellow,),backgroundColor: AppColor.black,
        title: Center(child: Text("Forget Password",style: TextStyle(
          fontSize: 18,fontWeight: FontWeight.w400,color: AppColor.yellow
        ),),

        ),),
        body:Column(
          children: [
            Image.asset("Asset/AppImage/forget .png"),
            SizedBox(height: 25,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: TextFormField(

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
            SizedBox(height: 16,),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 135, vertical: 15),
                foregroundColor: AppColor.black,
                backgroundColor: AppColor.yellow,
                textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text("Verify Email "),
            ),
          ],
        ),
      ),
    );
  }
}
