import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Asset/AppImage.dart';
import '../../../Core/Asset/Theme/AppColor.dart';
import '../../../bloc/history/history_bloc.dart';
import '../../../bloc/history/history_event.dart';
import '../../../bloc/history/history_state.dart';
import '../../../bloc/watchlist/watchlist_bloc.dart';
import '../../../bloc/watchlist/watchlist_event.dart';
import '../../../bloc/watchlist/watchlist_state.dart';
import '../../../models/movie.dart';
import '../HomeScreen/movie_details_screen.dart';
import '../widgets/responsive_movie_grid.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool _isWatchListSelected = true;

  @override
  void initState() {
    super.initState();
    context.read<WatchlistBloc>().add(LoadWatchlist());
    context.read<HistoryBloc>().add(LoadHistory());
  }

  void _navigateToDetails(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailsScreen(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'Movie Enthusiast';

    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Column(
          children: [
            // User Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Avatar
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.yellow, width: 2),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            AppImage.profile1,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const CircleAvatar(
                              backgroundColor: AppColor.gray,
                              child: Icon(Icons.person, color: AppColor.yellow, size: 36),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),

                      // Watchlist count
                      BlocBuilder<WatchlistBloc, WatchlistState>(
                        builder: (context, state) {
                          final count = state is WatchlistLoaded ? state.movies.length : 0;
                          return _buildStat('$count', 'Watch List');
                        },
                      ),
                      const SizedBox(width: 24),

                      // History count
                      BlocBuilder<HistoryBloc, HistoryState>(
                        builder: (context, state) {
                          final count = state is HistoryLoaded ? state.movies.length : 0;
                          return _buildStat('$count', 'History');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Name
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (user?.email != null)
                    Text(
                      user!.email!,
                      style: const TextStyle(
                        color: AppColor.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  const SizedBox(height: 14),

                  // Edit Profile & Exit Buttons
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Update_Porfile');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 44,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance.signOut();
                            } catch (_) {}
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(context, '/login');
                            }
                          },
                          icon: const Icon(Icons.logout, size: 16, color: Colors.white),
                          label: const Text('Exit', style: TextStyle(color: Colors.white, fontSize: 13)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.red,
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

            // Tab Selector (Watch List vs History)
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white12, width: 1),
                ),
              ),
              child: Row(
                children: [
                  _buildTab(
                    icon: Icons.bookmark_rounded,
                    label: 'Watch List',
                    isSelected: _isWatchListSelected,
                    onTap: () => setState(() => _isWatchListSelected = true),
                  ),
                  _buildTab(
                    icon: Icons.history_rounded,
                    label: 'History',
                    isSelected: !_isWatchListSelected,
                    onTap: () => setState(() => _isWatchListSelected = false),
                  ),
                ],
              ),
            ),

            // Content List / Grid
            Expanded(
              child: _isWatchListSelected
                  ? _buildWatchListContent()
                  : _buildHistoryContent(),
            ),
          ],
        ),
      ),
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
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: AppColor.textMuted, fontSize: 13),
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
    final color = isSelected ? AppColor.yellow : AppColor.textMuted;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColor.yellow : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWatchListContent() {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state is WatchlistLoaded) {
          if (state.movies.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bookmark_border_rounded, color: AppColor.yellow.withOpacity(0.5), size: 64),
                  const SizedBox(height: 12),
                  const Text(
                    'Your Watch List is empty',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Add movies to your watch list from movie details',
                    style: TextStyle(color: AppColor.textMuted, fontSize: 13),
                  ),
                ],
              ),
            );
          }
          return ResponsiveMovieGrid(
            movies: state.movies,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
            onMovieTap: (movie) => _navigateToDetails(context, movie),
          );
        }
        return const Center(child: CircularProgressIndicator(color: AppColor.yellow));
      },
    );
  }

  Widget _buildHistoryContent() {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoaded) {
          if (state.movies.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.history_rounded, color: AppColor.yellow.withOpacity(0.5), size: 64),
                  const SizedBox(height: 12),
                  const Text(
                    'No viewing history yet',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Movies you visit will be saved here automatically',
                    style: TextStyle(color: AppColor.textMuted, fontSize: 13),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recently Viewed (${state.movies.length})',
                      style: const TextStyle(color: AppColor.textMuted, fontSize: 13),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<HistoryBloc>().add(ClearHistory());
                      },
                      child: const Text('Clear All', style: TextStyle(color: AppColor.red, fontSize: 12)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ResponsiveMovieGrid(
                  movies: state.movies,
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                  onMovieTap: (movie) => _navigateToDetails(context, movie),
                ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator(color: AppColor.yellow));
      },
    );
  }
}
