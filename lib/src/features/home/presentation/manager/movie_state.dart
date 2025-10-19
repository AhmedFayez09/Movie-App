part of 'movie_cubit.dart';

@immutable
sealed class MovieState {}

final class MovieInitial extends MovieState {}
final class GetPopularMovieLoading extends MovieState {}
final class OpenSearchState extends MovieState {
  final bool openSearch;
  OpenSearchState(this.openSearch);
}
final class GetPopularMovieSuccess extends MovieState {
  final List<Results> movies;
  GetPopularMovieSuccess(this.movies);
}
final class GetPopularMovieError extends MovieState {
  final String msg;
  GetPopularMovieError(this.msg);
}

class GetPopularMoviePaginationLoading extends MovieState {
  final List<Results> oldMovies;
  GetPopularMoviePaginationLoading(this.oldMovies);
}
final class GetSearchMovieLoading extends MovieState {}

final class GetSearchMovieSuccess extends MovieState {
  final List<Results> movies;
  GetSearchMovieSuccess(this.movies);
}
final class GetSearchMovieError extends MovieState {
  final String msg;
  GetSearchMovieError(this.msg);
}
