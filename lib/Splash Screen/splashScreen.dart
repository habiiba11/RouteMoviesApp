import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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

            Image.asset('Assets/AppLogo/route.png', width: 220, height: 120),
          ],
        ),
      ),
    );
  }
}
