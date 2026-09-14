import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemovie/module/Screens/auth/Forget%20password.dart';
import 'package:routemovie/module/Screens/auth/Register.dart';
import 'package:routemovie/module/Screens/auth/Update_Porfile.dart';
import 'package:routemovie/module/Screens/auth/login.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home:Register(),
    );
  }
}
