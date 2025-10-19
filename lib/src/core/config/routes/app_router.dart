import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeema_task/src/core/networking/dio_factory.dart';
import 'package:qeema_task/src/features/home/logic/model/popular_movies_model.dart';
import 'package:qeema_task/src/features/home/logic/repo/movie_repo.dart';
import 'package:qeema_task/src/features/home/logic/repo/movie_repo_impl.dart';
import 'package:qeema_task/src/features/home/presentation/manager/movie_cubit.dart';
import 'package:qeema_task/src/features/home/presentation/screens/movie_details.dart';
import 'package:qeema_task/src/features/home/presentation/screens/movies_screen.dart';

import '../../../features/splash/presentation/screens/splash_screen.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case MoviesScreen.routeName:
        final dio = DioFactory.getDio();
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                MovieCubit(MoviesRepoImpl(dio))..getPopularMovie(),
            child: MoviesScreen(),
          ),
        );
      case MovieDetailsScreen.routeName:
        final movie = settings.arguments as Results;
        return MaterialPageRoute(
          builder: (context) => MovieDetailsScreen(movie: movie),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text("No route define for ${settings.name}")),
          ),
        );
    }
  }
}
