import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeema_task/src/core/config/routes/navigation.dart';
import 'package:qeema_task/src/core/extension/string.dart';
import 'package:qeema_task/src/features/home/logic/model/popular_movies_model.dart';
import 'package:qeema_task/src/features/home/presentation/manager/movie_cubit.dart';
import 'package:qeema_task/src/features/home/presentation/screens/movie_details.dart';
import 'package:qeema_task/src/features/home/presentation/widgets/movie_item.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().getPopularMovie();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = context.read<MovieCubit>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !cubit.isLoadingMore) {
      cubit.getPopularMovie(page: cubit.currentPage + 1);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        var cubit = context.read<MovieCubit>();
        final List<Results> movies = cubit.popularMovies;
        final List<Results>? searched = cubit.searchedList;

        final List<Results> listToShow =
            (searched != null && searched.isNotEmpty) ? searched : movies;

        if (movies.isEmpty && (state is GetPopularMovieLoading)) {
          return const Center(child: CircularProgressIndicator());
        }

        if (movies.isEmpty && state is GetPopularMovieError) {
          return Center(child: Text("No Internet"));
        }

        return RefreshIndicator(
          onRefresh: () async => cubit.getPopularMovie(),
          child: GridView.builder(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 250,
            ),
            itemCount: listToShow.length + (cubit.isLoadingMore ? 1 : 0),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemBuilder: (context, index) {
              if (index == listToShow.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final item = listToShow[index];
              return MovieItem(
                onTap: () {
                  CustomNavigator.instance.pushNamed(
                    MovieDetailsScreen.routeName,
                    arguments: item,
                  );
                },
                id: '${item.id}_$index',
                imageUrl: item.posterPath.fullLink,
                title: item.title,
                releaseYear: item.releaseDate,
                rating: item.voteAverage.toString(),
              );
            },
          ),
        );
      },
    );
  }
}
