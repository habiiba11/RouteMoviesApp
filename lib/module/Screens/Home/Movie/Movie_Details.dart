import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routemovie/Core/Asset/AppImage.dart';
import 'package:routemovie/Core/Asset/Theme/AppColor.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        backgroundColor: AppColor.black,
        leading: Icon(Icons.arrow_back_ios, color: AppColor.white),
        actions: [
          SvgPicture.asset(
            "Asset/Svg/saved.svg",
            height: 29,
            width: 20,
            alignment: AlignmentGeometry.topEnd,
          ),
        ],
      ),
      body:Stack(
        fit:StackFit.expand,
        children: [
          Image.asset(AppImage.onboarding5,)
        ],
      )
    );
  }
}
