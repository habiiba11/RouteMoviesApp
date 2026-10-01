import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:routemovie/Core/Asset/AppLogo.dart';
import 'package:routemovie/Core/Asset/Theme/AppColor.dart';
import 'package:routemovie/movie_api.dart';

TextStyle _bold(double size) => TextStyle(
  color: AppColor.white,
  fontSize: size,
  fontWeight: FontWeight.w700,
);

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late final Future<List<Object>> _future = Future.wait<Object>([
    MovieApi.details(widget.movieId),
    MovieApi.suggestions(widget.movieId),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: AppColor.white),
        ),
        actions: [
          SvgPicture.asset(
            "Asset/Svg/saved.svg",
            colorFilter: ColorFilter.mode(AppColor.white, BlendMode.srcIn),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: FutureBuilder<List<Object>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator(color: AppColor.red));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong", style: _bold(16)),
            );
          }
          final movie = snapshot.data![0] as Map<String, dynamic>;
          final similar = snapshot.data![1] as List<dynamic>;
          return _Content(movie: movie, similar: similar);
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.movie, required this.similar});

  final Map<String, dynamic> movie;
  final List<dynamic> similar;

  @override
  Widget build(BuildContext context) {
    final screenshots = [
      movie['large_screenshot_image1'],
      movie['large_screenshot_image2'],
      movie['large_screenshot_image3'],
    ].whereType<String>().toList();
    final cast = (movie['cast'] as List?) ?? [];
    final genres = (movie['genres'] as List?) ?? [];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Hero(movie: movie),
          if (screenshots.isNotEmpty)
            _Section(
              title: "Screen Shots",
              child: Column(
                children: [
                  for (final url in screenshots)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(url, width: double.infinity),
                      ),
                    ),
                ],
              ),
            ),
          if (similar.isNotEmpty)
            _Section(
              title: "Similar",
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 189 / 279,
                children: [
                  for (final m in similar.take(4))
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetails(movieId: m['id']),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          m['medium_cover_image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          _Section(
            title: "Summary",
            child: Text(
              movie['description_full'] ?? '',
              style: _bold(16),
            ),
          ),
          if (cast.isNotEmpty)
            _Section(
              title: "Cast",
              child: Column(
                children: [for (final c in cast) _CastCard(actor: c)],
              ),
            ),
          if (genres.isNotEmpty)
            _Section(
              title: "Genres",
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [for (final g in genres) _GenreChip(label: '$g')],
              ),
            ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.movie});

  final Map<String, dynamic> movie;

  @override
  Widget build(BuildContext context) {
    final trailer = movie['yt_trailer_code'] as String?;

    return SizedBox(
      height: 720,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(movie['background_image'], fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xff121312).withValues(alpha: 0.2),
                  const Color(0xff121312),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, kToolbarHeight, 16, 0),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(Applogo.video_logo, width: 97, height: 97),
                const Spacer(),
                Text(
                  movie['title'] ?? '',
                  textAlign: TextAlign.center,
                  style: _bold(24),
                ),
                const SizedBox(height: 16),
                Text('${movie['year']}', style: _bold(20)),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: (trailer == null || trailer.isEmpty)
                        ? null
                        : () => launchUrl(
                      Uri.parse('https://www.youtube.com/watch?v=$trailer'),
                      mode: LaunchMode.externalApplication,
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColor.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text("Watch", style: _bold(20)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _StatButton(icon: 'heart', value: '${movie['like_count']}'),
                    const SizedBox(width: 16),
                    _StatButton(icon: 'clock', value: '${movie['runtime']}'),
                    const SizedBox(width: 16),
                    _StatButton(icon: 'star', value: '${movie['rating']}'),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatButton extends StatelessWidget {
  const _StatButton({required this.icon, required this.value});

  final String icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton.icon(
        onPressed: () {},
        icon: SvgPicture.asset('Asset/Svg/$icon.svg'),
        label: Text(value, style: TextStyle(color: AppColor.white)),
        style: FilledButton.styleFrom(
          backgroundColor: AppColor.gray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _bold(24)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({required this.actor});

  final Map<String, dynamic> actor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColor.gray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              actor['url_small_image'] ?? '',
              height: 70,
              width: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 70,
                width: 70,
                color: Colors.black26,
                child: Icon(Icons.person, color: AppColor.white),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name : ${actor['name']}", style: _bold(16)),
                const SizedBox(height: 8),
                Text("Character : ${actor['character_name']}", style: _bold(16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  const _GenreChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.gray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label, style: _bold(16)),
    );
  }
}