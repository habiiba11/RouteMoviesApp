import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/movie_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository _repository;

  HomeBloc({required MovieRepository repository})
      : _repository = repository,
        super(HomeInitial()) {
    on<FetchHomeData>(_onFetchHomeData);
  }

  Future<void> _onFetchHomeData(
    FetchHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final results = await Future.wait([
        _repository.getFeaturedMovies(),
        _repository.getPopularMovies(),
        _repository.getTopRatedMovies(),
      ]);

      final featured = results[0];
      final popular = results[1];
      final topRated = results[2];

      emit(HomeLoaded(
        featuredMovies: featured,
        popularMovies: popular,
        topRatedMovies: topRated,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
