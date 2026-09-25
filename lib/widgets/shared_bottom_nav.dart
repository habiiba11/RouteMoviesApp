import 'package:flutter/material.dart';

class SharedBottomNav extends StatelessWidget {
  final int currentIndex;

  const SharedBottomNav({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/search');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/discover');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, index: 0, icon: Icons.home),
            _buildNavItem(context, index: 1, icon: Icons.search),
            _buildNavItem(context, index: 2, icon: Icons.explore_outlined),
            _buildNavItem(context, index: 3, icon: Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
  }) {
    final bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () => _onTap(context, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? const Color(0xFFF5B800) : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.white54,
          size: 22,
        ),
      ),
    );
  }
}
