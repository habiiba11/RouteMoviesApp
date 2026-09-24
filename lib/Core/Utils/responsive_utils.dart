import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static int getGridCrossAxisCount(
    BuildContext context, {
    double itemMinWidth = 110,
    int minColumns = 2,
    int maxColumns = 6,
  }) {
    final width = MediaQuery.of(context).size.width;
    final count = (width / itemMinWidth).floor();
    return count.clamp(minColumns, maxColumns);
  }

  static double getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 64.0;
    if (width > 800) return 32.0;
    return 16.0;
  }
}
