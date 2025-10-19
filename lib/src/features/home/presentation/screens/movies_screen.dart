import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeema_task/src/features/home/presentation/manager/movie_cubit.dart';
import 'package:qeema_task/src/features/home/presentation/widgets/search_movie_icon.dart';

import '../widgets/movie_list.dart' show MovieList;

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  static const routeName = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            final cubit = context.read<MovieCubit>();
            return cubit.openSearch
                ? TextField(
                    onChanged: (value) {
                      cubit.searchMovies(title: value);
                    },
                  )
                : Text("Popular Movies");
          },
        ),
        actions: [SearchMovieIcon()],
      ),
      body: MovieList(),
    );
  }
}
