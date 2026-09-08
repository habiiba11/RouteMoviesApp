import 'dart:async';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'Assets/AppLogo/logo.png',
                width: 250,
                height: 250,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset('Assets/AppImages/route.png', width: 220, height: 120),
          ],
        ),
      ),
    );
  }
}
