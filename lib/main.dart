import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemovie/module/Screens/auth/Forget%20password.dart';
import 'package:routemovie/module/Screens/auth/Register.dart';
import 'package:routemovie/module/Screens/auth/Update_Porfile.dart';
import 'package:routemovie/module/Screens/auth/login.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.roboto().fontFamily
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
