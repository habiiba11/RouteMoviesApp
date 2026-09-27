import 'package:flutter/material.dart';
import 'package:routemovie/routes/app_routes.dart';

import '../../../Core/Asset/Theme/AppColor.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool showAvatars = false;

  String selectedAvatar = 'Asset/AppImage/profile8.png';

  final List<String> avatars = [
    'Asset/AppImage/profile1.png',
    'Asset/AppImage/porfile2.png',
    'Asset/AppImage/profile8.png',
    'Asset/AppImage/profile4.png',
    'Asset/AppImage/profile5.png',
    'Asset/AppImage/profile6.png',
    'Asset/AppImage/profile7.png',
    'Asset/AppImage/profile3.png',
    'Asset/AppImage/profile9.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColor.yellow,
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Update Profile',
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),

                  const SizedBox(height: 30),

                  ClipOval(
                    child: Image.asset(
                      selectedAvatar,
                      width: 135,
                      height: 135,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppColor.gray,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 15),
                        Icon(
                          Icons.person,
                          color: AppColor.white,
                        ),
                        SizedBox(width: 15),
                        Text(
                          'John Safwat',
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppColor.gray,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 15),
                        Icon(
                          Icons.phone,
                          color: AppColor.white,
                        ),
                        SizedBox(width: 15),
                        Text(
                          '0120000000',
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 260),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.splash,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Delete Account',
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showAvatars = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Update Data',
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),

            if (showAvatars)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showAvatars = false;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),

            if (showAvatars)
              Positioned(
                left: 25,
                right: 25,
                bottom: 100,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColor.gray,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Pick Avatar',
                        style: TextStyle(
                          color: AppColor.yellow,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: avatars.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final avatar = avatars[index];

                          final bool isSelected =
                              selectedAvatar == avatar;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedAvatar = avatar;
                                showAvatars = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.yellow
                                      : AppColor.yellow.withOpacity(0.6),
                                  width: isSelected ? 3 : 1.5,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(11),
                                    child: Image.asset(
                                      avatar,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  if (isSelected)
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.yellow
                                              .withOpacity(0.45),
                                          borderRadius:
                                          BorderRadius.circular(11),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}