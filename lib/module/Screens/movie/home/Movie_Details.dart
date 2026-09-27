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
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: 120,
                            vertical: 16,
                          ),

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
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'Asset/Svg/heart.svg',
                                ),
                                label: Text(
                                  "15",
                                  style: TextStyle(
                                    color: AppColor.white,
                                  ),
                                ),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColor.gray,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 16),

                            Expanded(
                              child: FilledButton.icon(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'Asset/Svg/clock.svg',
                                ),
                                label: Text(
                                  "90",
                                  style: TextStyle(
                                    color: AppColor.white,
                                  ),
                                ),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColor.gray,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 16),

                            Expanded(
                              child: FilledButton.icon(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'Asset/Svg/star.svg',
                                ),
                                label: Text(
                                  "7.6",
                                  style: TextStyle(
                                    color: AppColor.white,
                                  ),
                                ),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColor.gray,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 35,
                      ),

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
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Container(
                        height: 279,
                        width: 189,
                        child: Image.asset(AppImage.film1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 279,
                        width: 189,
                        child: Image.asset(AppImage.film2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Container(
                        height: 279,
                        width: 189,
                        child: Image.asset(AppImage.film3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 279,
                        width: 189,
                        child: Image.asset(AppImage.film4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    child: Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Text(
                        "Summary",
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      "Cast",
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    height: 92,
                    width: 398,
                    decoration: BoxDecoration(
                      color: AppColor.gray,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 11),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            AppImage.actor1,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 16),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name : Hayley Atwell",
                              style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              "Character : Captain Carter",
                              style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 92,
                    width: 398,
                    decoration: BoxDecoration(
                      color: AppColor.gray,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 11),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            AppImage.actor2,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 16),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name : Elizabeth Olsen",
                              style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              "Character : Wanda Maximoff /\n The Scarlet Witch",
                              style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 92,
                    width: 398,
                    decoration: BoxDecoration(
                      color: AppColor.gray,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 11),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            AppImage.actor3,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 16),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name : Rachel McAdams",
                              style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              "Character : Dr. Christine Palmer",
                              style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 92,
                    width: 398,
                    decoration: BoxDecoration(
                      color: AppColor.gray,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 11),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            AppImage.actor4,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 16),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name : Charlize Theron",
                              style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              "Character : Clea",
                              style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Genres",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),
                ),

                SizedBox(height: 16),

                Row(
                  children: [
                    Container(
                      height: 36,
                      width: 122,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.gray,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Action",
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    SizedBox(width: 16),

                    Container(
                      height: 36,
                      width: 122,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.gray,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Sci-Fi",
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    SizedBox(width: 16),

                    Container(
                      height: 36,
                      width: 122,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.gray,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Adventure",
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                Row(
                  children: [
                    Container(
                      height: 36,
                      width: 122,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.gray,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Fantasy",
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    SizedBox(width: 16),

                    Container(
                      height: 36,
                      width: 122,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.gray,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Horror",
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 57,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
