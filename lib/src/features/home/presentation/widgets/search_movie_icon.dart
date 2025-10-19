import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeema_task/src/features/home/presentation/manager/movie_cubit.dart';

class SearchMovieIcon extends StatelessWidget {
  const SearchMovieIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        final cubit = context.read<MovieCubit>();
        return cubit.openSearch
            ? IconButton(
                onPressed: () {
                  cubit.openSearchBar();
                  cubit.searchMovies();
                },
                icon: Icon(Icons.cancel),
              )
            : IconButton(
                onPressed: () {
                  cubit.openSearchBar();
                },
                icon: Icon(Icons.search),
              );
      },
    );
  }
}
