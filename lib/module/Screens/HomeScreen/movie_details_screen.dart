import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:routemovie/Core/Asset/AppLogo.dart';
import 'package:routemovie/Core/Asset/Theme/AppColor.dart';
import 'package:routemovie/models/movie.dart';
import 'package:routemovie/models/movie_details.dart';
import 'package:routemovie/movie_api.dart';

TextStyle _bold(double size) => TextStyle(
  color: AppColor.white,
  fontSize: size,
  fontWeight: FontWeight.w700,
);

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, this.movieId = 10});

  final int movieId;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
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
            debugPrint('MOVIE ERROR: ${snapshot.error}');
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('${snapshot.error}', style: _bold(14), textAlign: TextAlign.center),
              ),
            );
          }
          return _Content(
            details: snapshot.data![0] as MovieDetails,
            similar: snapshot.data![1] as List<Movie>,
          );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.details, required this.similar});

  final MovieDetails details;
  final List<Movie> similar;

  @override
  Widget build(BuildContext context) {
    final movie = details.movie;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Hero(details: details),
          if (details.screenshots.isNotEmpty)
            _Section(
              title: "Screen Shots",
              child: Column(
                children: [
                  for (final url in details.screenshots)
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
                          builder: (_) => MovieDetailsScreen(movieId: m.id),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          m.posterUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          _Section(
            title: "Summary",
            child: Text(movie.descriptionFull, style: _bold(16)),
          ),
          if (details.cast.isNotEmpty)
            _Section(
              title: "Cast",
              child: Column(
                children: [for (final c in details.cast) _CastCard(actor: c)],
              ),
            ),
          if (movie.genres.isNotEmpty)
            _Section(
              title: "Genres",
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final g in movie.genres) _GenreChip(label: g),
                ],
              ),
            ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.details});

  final MovieDetails details;

  @override
  Widget build(BuildContext context) {
    final movie = details.movie;

    return SizedBox(
      height: 720,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(movie.backgroundImage, fit: BoxFit.cover),
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
                Text(movie.title, textAlign: TextAlign.center, style: _bold(24)),
                const SizedBox(height: 16),
                Text('${movie.year}', style: _bold(20)),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: details.trailerCode.isEmpty
                        ? null
                        : () => launchUrl(
                      Uri.parse(
                          'https://www.youtube.com/watch?v=${details.trailerCode}'),
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
                    _StatButton(icon: 'heart', value: '${details.likeCount}'),
                    const SizedBox(width: 16),
                    _StatButton(icon: 'clock', value: '${movie.runtime}'),
                    const SizedBox(width: 16),
                    _StatButton(icon: 'star', value: '${movie.rating}'),
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

  final CastMember actor;

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
              actor.profilePhoto,
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
                Text("Name : ${actor.name}", style: _bold(16)),
                const SizedBox(height: 8),
                Text("Character : ${actor.characterName}", style: _bold(16)),
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