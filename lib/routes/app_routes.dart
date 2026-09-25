import 'package:flutter/material.dart';
import 'package:routemovie/module/Screens/auth/Forget%20password.dart';
import 'package:routemovie/module/Screens/auth/Register.dart';
import 'package:routemovie/module/Screens/auth/Update_Porfile.dart';
import 'package:routemovie/module/Screens/auth/login.dart';
import 'package:routemovie/module/Screens/movie/home/Movie_Details.dart';
import '../module/Screens/Onboarding/onboarding_screen1.dart';
import '../module/Screens/Onboarding/onboarding_screen2.dart';
import '../module/Screens/Onboarding/onboarding_screen3.dart';
import '../module/Screens/Onboarding/onboarding_screen4.dart';
import '../module/Screens/Onboarding/onboarding_screen5.dart';
import '../module/Screens/Onboarding/onboarding_screen6.dart';
import '../module/Screens/Splash Screen/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding1 = '/onboarding1';
  static const String onboarding2 = '/onboarding2';
  static const String onboarding3 = '/onboarding3';
  static const String onboarding4 = '/onboarding4';
  static const String onboarding5 = '/onboarding5';
  static const String onboarding6 = '/onboarding6';
  static const String login = '/login';
  static const String register = '/Register';
  static const String updateProfile= '/Update_Porfile';
  static const String updateProfile2= '/Update_Profile2';
  static const String forgetPassword = '/Forget password';
  static const String  Movie_details = '/Movie_Details';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case onboarding1:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen1());

      case onboarding2:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen2());

      case onboarding3:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen3());

      case onboarding4:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen4());

      case onboarding5:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen5());

      case onboarding6:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen6());
        case login:
        return MaterialPageRoute(builder: (_) => Login());
        case register:
        return MaterialPageRoute(builder: (_) =>  Register());
        case forgetPassword:
        return MaterialPageRoute(builder: (_) => Forgetpassword());
        case updateProfile:
        return MaterialPageRoute(builder: (_) => const UpdateProfileScreen());
        case Movie_details:
        return MaterialPageRoute(builder: (_) => const MovieDetails());




      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }

}
