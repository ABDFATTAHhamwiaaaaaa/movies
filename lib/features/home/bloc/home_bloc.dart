

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movizone/core/unified_api/status.dart';
import 'package:movizone/features/home/data/repo/home_repo.dart';

import '../data/model/credits_model.dart';
import '../data/model/genres_response_model.dart';
import '../data/model/movie_details_model.dart';
import '../data/model/reviews_model.dart';
import '../data/model/top_rated_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<Getcategories>((event, emit) async {
      emit(state.copyWith(categoriesStatus: Status.loading));
      final result = await HomeRepo().getGenres();
      result.fold(
          (l) => state.copyWith(categoriesStatus: Status.failed),
          (r) => state.copyWith(
              categoriesStatus: Status.success, genres: r.genres));
    });
    on<GetTopRated>((event, emit) async {
      emit(state.copyWith(topRatedStatus: Status.loading));
      final result = await HomeRepo().getTopRatedasync();
      result.fold(
          (l) => state.copyWith(categoriesStatus: Status.failed),
          (r) => state.copyWith(
              categoriesStatus: Status.success,
              topRated: r.results?.sublist(0, 5)));
    });
    on<GetmoviesEvent>((event, emit) async {
      emit(state.copyWith(moviesStatue: Status.loading));
      final result = await HomeRepo().getTopRatedasync();
      result.fold(
          (l) => state.copyWith(categoriesStatus: Status.failed),
          (r) => state.copyWith(
              categoriesStatus: Status.success, movies: r.results));
    });
    on<GetDetadilsEvent>((event, emit) async {
      emit(state.copyWith(  detailsStatus: Status.loading,
          reviewsStatus: Status.initial,
          creditsStatus: Status.initial));
      final result = await HomeRepo().getDetails(event.movieId );
      result.fold(
          (l) => state.copyWith(detailsStatus: Status.failed),
          (r) =>
              state.copyWith(detailsStatus: Status.success, movieDetails: r));
          
          add(GetReviwesEvent(event.movieId));
          add(GetCreditsEvent(event.movieId));
    });
    on<GetReviwesEvent>((event, emit) async {
      emit(state.copyWith(reviewsStatus: Status.loading));
      final result = await HomeRepo().getReviews(event.movieId);
      result.fold(
          (l) => state.copyWith(reviewsStatus: Status.failed),
          (r) =>
              state.copyWith(reviewsStatus: Status.success, review: r.results));
    });
    on<GetCreditsEvent>((event, emit) async {
      emit(state.copyWith(creditsStatus: Status.loading));
      final result = await HomeRepo().getCredits(event.movieId);
      result.fold((l) => state.copyWith(creditsStatus: Status.failed),
          (r) => state.copyWith(creditsStatus: Status.success, cast: r.cast));
    });
  }
}
