import 'package:flutter/material.dart';

import '/models/movie.dart';
import '/data/movies_data.dart';
import '/../widgets/shared_bottom_nav.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isWatchListSelected = true;

  final List<Movie> watchListMovies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage(
                          'Assets/AppLogo/profile.png',
                        ),
                      ),
                      const SizedBox(width: 30),
                      _buildStat('${watchListMovies.length}', 'Wish List'),
                      const SizedBox(width: 30),
                      _buildStat('${historyMovies.length}', 'History'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'John Safwat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 53,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/updateProfile');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF5B800),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.logout,
                            size: 18,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Exit',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Row(
              children: [
                _buildTab(
                  icon: Icons.menu,
                  label: 'Watch List',
                  isSelected: isWatchListSelected,
                  onTap: () => setState(() => isWatchListSelected = true),
                ),
                _buildTab(
                  icon: Icons.folder,
                  label: 'History',
                  isSelected: !isWatchListSelected,
                  onTap: () => setState(() => isWatchListSelected = false),
                ),
              ],
            ),

            Expanded(
              child: isWatchListSelected
                  ? _buildMovieGrid(watchListMovies)
                  : _buildMovieGrid(historyMovies),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SharedBottomNav(currentIndex: 3),
    );
  }

  Widget _buildStat(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildTab({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final color = isSelected ? const Color(0xFFF5B800) : Colors.white54;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? const Color(0xFFF5B800)
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(color: color, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieGrid(List<Movie> movies) {
    if (movies.isEmpty) {
      return const Center(
        child: Icon(Icons.card_giftcard, color: Colors.white24, size: 60),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                movie.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              top: 4,
              left: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFF5B800), size: 10),
                    const SizedBox(width: 2),
                    Text(
                      movie.rating,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
