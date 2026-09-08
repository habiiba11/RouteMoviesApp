import 'package:flutter/material.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        
          Positioned.fill(
            child: Image.asset(
              'Assets/AppImage/onboarding3.jpg',
              fit: BoxFit.cover,
            ),
          ),

      
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF084250),
                    Color.fromARGB(0, 13, 89, 108),
                    Color(0xFF084250),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 15,
              ),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Explore All Genres',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                 Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30),
  child: const Text(
    'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
  ),
),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/onboarding4');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5B800),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFFF5B800),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}