import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qeema_task/src/features/home/logic/model/popular_movies_model.dart';
import 'package:qeema_task/src/features/home/logic/repo/movie_repo.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit(this.movieRepo) : super(MovieInitial());
  final MovieRepo movieRepo;

  List<Results> popularMovies = [];
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = true;

  Future<void> getPopularMovie({int page = 1}) async {
    if (page == 1) {
      emit(GetPopularMovieLoading());
      popularMovies.clear();
      hasMore = true;
      currentPage = 1;
    } else {
      emit(GetPopularMoviePaginationLoading( popularMovies));
      isLoadingMore = true;
    }

    final result = await movieRepo.getPopularMovies(page: page);
    result.when(
      success: (r) {
        final fetched = r.results ?? [];

        if (page == 1) {
          popularMovies = fetched;
        } else {
          popularMovies.addAll(fetched);
        }

        hasMore = fetched.isNotEmpty;
        currentPage = page;
        isLoadingMore = false;

        emit(GetPopularMovieSuccess(popularMovies));
      },
      failure: (l) {
        isLoadingMore = false;
        emit(GetPopularMovieError(
          l.apiErrorModel.message ?? 'Something went wrong',
        ));
      },
    );
  }

   bool openSearch = false;
  void openSearchBar() {
    openSearch = !openSearch;
    emit(OpenSearchState(openSearch));
  }

  List<Results>? searchedList;
  void searchMovies({String? title}) async {
    emit(GetSearchMovieLoading());
    final result = await movieRepo.searchMovies(title: title);
    result.when(
      success: (r) {
        searchedList = r.results;
        emit(GetSearchMovieSuccess(r.results ?? []));
      },
      failure: (l) {
        emit(GetSearchMovieError(
          l.apiErrorModel.message ?? 'Something went wrong',
        ));
      },
    );
  }


}

