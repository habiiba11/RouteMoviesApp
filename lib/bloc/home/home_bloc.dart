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
      ]);

      final featured = results[0];
      final popular = results[1];

      emit(HomeLoaded(
        featuredMovies: featured,
        popularMovies: popular,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}