// ignore_for_file: avoid_single_cascade_in_expression_statements
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qeema_task/src/core/networking/failures.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);
    if (dio == null) {
      dio = Dio();
      dio!..options.connectTimeout = timeOut;
      dio!..options.receiveTimeout = timeOut;
      addDioInterceptor();
      addDioHeaders();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('➡️ REQUEST [${options.method}] => PATH: ${options.path}');
          log('Base: ${options.baseUrl}');
          log('Headers: ${options.headers}');
          log('Data: ${options.data}');
          log('Query: ${options.queryParameters}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log(
            '✅ RESPONSE [${response.statusCode}] => PATH: ${response.requestOptions.path}',
          );
          log('Response Data: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          log(
            '❌ ERROR [${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
          );
          log('Error Message: ${error.message}');
          log('Error Data: ${error.response?.data}');
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              type: DioExceptionType.unknown,
              error: ServerFailure.fromDioError(error),
            ),
          );
        },
      ),
    );
  }

  static void addDioHeaders() {
    dio?.options.baseUrl = dotenv.env['BASE_URL'] ?? '';
    dio?.options.queryParameters = {"api_key": dotenv.env['API_KEY'] ?? ''};
    dio?.options.headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
  }

}
