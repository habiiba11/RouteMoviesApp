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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFF282A28),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(index: 0, icon: Icons.home_filled, label: 'Home'),
          _buildNavItem(index: 1, icon: Icons.search, label: 'Search'),
          _buildNavItem(index: 2, icon: Icons.explore_outlined, label: 'Browse'),
          _buildNavItem(index: 3, icon: Icons.person, label: 'Profile'),
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
      child: SizedBox(
        width: 54,
        height: 54,
        child: Center(
          child: Icon(
            icon,
            color: isSelected ? AppColor.yellow : Colors.white,
            size: 26,
          ),
        ),
      ),
    );
  }
}
