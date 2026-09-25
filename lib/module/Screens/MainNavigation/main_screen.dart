import 'package:flutter/material.dart';
import '../../../Core/Asset/Theme/AppColor.dart';
import '../HomeScreen/browes_screen.dart';
import '../HomeScreen/home_tab.dart';
import '../HomeScreen/search_screen.dart';
import '../Profile/profile_tab.dart';
import 'widgets/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  final List<Widget> _tabs = const [
    HomeTab(),
    SearchScreen(),
    BrowseScreen(),
    ProfileTab(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Preserve tab states using IndexedStack
          IndexedStack(
            index: _currentIndex,
            children: _tabs,
          ),

          // Floating Custom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: CustomBottomNavBar(
                currentIndex: _currentIndex,
                onTap: _onTabSelected,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
