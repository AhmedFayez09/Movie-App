import 'package:dio/dio.dart';
import 'package:qeema_task/src/core/networking/api_result.dart';
import 'package:qeema_task/src/features/home/logic/model/popular_movies_model.dart';

abstract class MovieRepo {
  final Dio dio;

  MovieRepo(this.dio);

  Future<ApiResult<PopularMoviesModel>> getPopularMovies({int? page = 1});

  Future<ApiResult<PopularMoviesModel>> searchMovies({String? title});
}
