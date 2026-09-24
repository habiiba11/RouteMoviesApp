import 'package:flutter/material.dart';
import '../../../Core/Asset/Theme/AppColor.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeMore;
  final bool showSeeMore;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeMore,
    this.showSeeMore = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          if (showSeeMore)
            GestureDetector(
              onTap: onSeeMore,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'See More',
                    style: TextStyle(
                      color: AppColor.yellow,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, color: AppColor.yellow, size: 12),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
