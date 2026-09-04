import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemovie/module/Screens/auth/Forget%20password.dart';
import 'package:routemovie/module/Screens/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.roboto().fontFamily
      ),
      debugShowCheckedModeBanner: false,
      home:Login(),
    );
  }
}
