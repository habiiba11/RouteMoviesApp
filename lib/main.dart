import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Core/Asset/Theme/AppColor.dart';
import 'Core/Services/local_storage_service.dart';
import 'Core/Services/yts_api_service.dart';
import 'bloc/browse/browse_bloc.dart';
import 'bloc/details/movie_details_bloc.dart';
import 'bloc/history/history_bloc.dart';
import 'bloc/home/home_bloc.dart';
import 'bloc/search/search_bloc.dart';
import 'bloc/watchlist/watchlist_bloc.dart';
import 'firebase_options.dart';
import 'module/Screens/MainNavigation/main_screen.dart';
import 'repository/movie_repository.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase safely
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase init note: $e');
  }

  // Initialize Local Storage & Repository
  final localStorage = await LocalStorageService.create();
  final apiService = YtsApiService();
  final movieRepository = MovieRepository(
    apiService: apiService,
    storageService: localStorage,
  );

  runApp(MyApp(movieRepository: movieRepository));
}

class MyApp extends StatelessWidget {
  final MovieRepository movieRepository;

  const MyApp({super.key, required this.movieRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: movieRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(repository: movieRepository),
          ),
          BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(repository: movieRepository),
          ),
          BlocProvider<BrowseBloc>(
            create: (context) => BrowseBloc(repository: movieRepository),
          ),
          BlocProvider<WatchlistBloc>(
            create: (context) => WatchlistBloc(repository: movieRepository),
          ),
          BlocProvider<HistoryBloc>(
            create: (context) => HistoryBloc(repository: movieRepository),
          ),
          BlocProvider<MovieDetailsBloc>(
            create: (context) => MovieDetailsBloc(repository: movieRepository),
          ),
        ],
        child: MaterialApp(
          title: 'Route Movies',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColor.black,
            primaryColor: AppColor.yellow,
            colorScheme: const ColorScheme.dark(
              primary: AppColor.yellow,
              secondary: AppColor.yellow,
              surface: AppColor.gray,
            ),
            textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColor.black,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
            ),
          ),
          onGenerateRoute: AppRoutes.generateRoute,
          home: const MainScreen(),
        ),
      ),
    );
  }
}
