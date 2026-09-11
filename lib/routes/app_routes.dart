import 'package:flutter/material.dart';
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

  // static const String home = '/home';
  // static const String login = '/login';

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

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
