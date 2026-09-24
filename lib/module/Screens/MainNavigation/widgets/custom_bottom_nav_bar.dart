import 'package:flutter/material.dart';
import '../../../../Core/Asset/Theme/AppColor.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      height: 62,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(index: 0, icon: Icons.home_rounded, label: 'Home'),
          _buildNavItem(index: 1, icon: Icons.search_rounded, label: 'Search'),
          _buildNavItem(index: 2, icon: Icons.explore_rounded, label: 'Browse'),
          _buildNavItem(index: 3, icon: Icons.person_rounded, label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = index == currentIndex;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColor.yellow : Colors.transparent,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColor.yellow.withOpacity(0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.white60,
          size: 24,
        ),
      ),
    );
  }
}
