import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routemovie/Core/Asset/AppImage.dart';
import 'package:routemovie/Core/Asset/AppLogo.dart';
import 'package:routemovie/Core/Asset/Theme/AppColor.dart';
import 'package:routemovie/routes/app_routes.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        leading: InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          },
          child: Icon(Icons.arrow_back_ios, color: AppColor.white),
        ),

        actions: [
          SvgPicture.asset("Asset/Svg/saved.svg", color: AppColor.white),
          SizedBox(width: 16),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "Asset/AppImage/onboarding5.jpg",
                  width: double.infinity,
                  height: 720,
                  fit: BoxFit.cover,
                ),

                Container(
                  width: double.infinity,
                  height: 720,

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff121312).withValues(alpha: 0.2),
                        Color(0xff121312),
                      ],
                    ),
                  ),

                  child: Column(
                    children: [
                      SizedBox(height: 171),

                      Image.asset(Applogo.video_logo, width: 97, height: 97),

                      SizedBox(height: 188),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28),
                        child: Text(
                          "Doctor Strange in the Multiverse\n"
                          "of Madness",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColor.white,
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        "2022",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColor.white,
                        ),
                      ),

                      SizedBox(height: 8),
                      FilledButton(
                          onPressed: () {},

                          style: FilledButton.styleFrom(
                            backgroundColor: AppColor.red,
                               padding: EdgeInsetsGeometry.symmetric(horizontal: 120,vertical: 16),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),

                          child: Text(
                            "Watch",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: AppColor.white,
                            ),
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),

                        child: Row(
                          children: [
                            FilledButton.icon(
                              onPressed: () {},

                              icon: SvgPicture.asset('Asset/Svg/heart.svg'),

                              style: FilledButton.styleFrom(
                                backgroundColor: AppColor.gray,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),

                              label: Text("15"),
                            ),

                            SizedBox(width: 16),

                            FilledButton.icon(
                              onPressed: () {},

                              icon: SvgPicture.asset('Asset/Svg/clock.svg'),

                              style: FilledButton.styleFrom(
                                backgroundColor: AppColor.gray,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),

                              label: Text("90"),
                            ),

                            SizedBox(width: 16),

                            FilledButton.icon(
                              onPressed: () {},

                              icon: SvgPicture.asset('Asset/Svg/star.svg'),

                              style: FilledButton.styleFrom(
                                backgroundColor: AppColor.gray,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),

                              label: Text("7.6"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Container(
              width: double.infinity,
              color: Colors.black,

              child: Column(
                children: [


                  Align(
                    alignment: Alignment.centerLeft,

                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),

                      child: Text(
                        "Screen Shots",
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  Image.asset(AppImage.movieDetails1),

                  SizedBox(height: 14),

                  Image.asset(AppImage.movieDetails2),

                  SizedBox(height: 14),

                  Image.asset(AppImage.movieDetails3),
                ],
              ),
            ),

            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,

                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 35),

                      child: Text(
                        "Similar ",
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(

                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
