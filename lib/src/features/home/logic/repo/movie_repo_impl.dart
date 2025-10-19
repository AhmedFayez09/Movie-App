import 'package:dio/dio.dart';
import 'package:qeema_task/src/core/networking/api_error_handler.dart';
import 'package:qeema_task/src/core/networking/api_result.dart';
import 'package:qeema_task/src/core/utils/end_point.dart';
import 'package:qeema_task/src/features/home/logic/model/popular_movies_model.dart';
import 'package:qeema_task/src/features/home/logic/repo/movie_repo.dart';

class MoviesRepoImpl extends MovieRepo {
  MoviesRepoImpl(super.dio);

  @override
  Future<ApiResult<PopularMoviesModel>> getPopularMovies({
    int? page = 1,
  }) async {
    try {
      final response = await dio.get(
        EndPoint.popularMovies,
        queryParameters: {"page": page},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = PopularMoviesModel.fromJson(response.data);
        return ApiResult.success(user);
      } else {
        return ApiResult.failure(
          ErrorHandler.handle(response.data['message'].toString()),
        );
      }
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e.toString()));
    }
  }

  @override
  Future<ApiResult<PopularMoviesModel>> searchMovies({String? title})async {
    try {
      final response = await dio.get(
        EndPoint.searchMovies,
        queryParameters: {"query": title},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = PopularMoviesModel.fromJson(response.data);
        return ApiResult.success(user);
      } else {
        return ApiResult.failure(
          ErrorHandler.handle(response.data['message'].toString()),
        );
      }
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e.toString()));
    }
  }
}
