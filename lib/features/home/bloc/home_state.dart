part of 'home_bloc.dart';

class HomeState {
  final List<MovieModel> topRated;
  final List<MovieModel> movies;
  final List<GenreModel> genres;
  final List<Cast> cast;
  final List<ReviewModel> review;
  final MovieDetailsResponseModel? movieDetails;

  final Status detailsStatus;
  final Status creditsStatus;
  final Status reviewsStatus;
  final Status topRatedStatus;
  final Status categoriesStatus;
  final Status moviesStatue;

  HomeState(
      {this.topRated = const [],
      this.movies = const [],
      this.genres = const [],
      this.cast = const [],
      this.review = const [],
      this.movieDetails,
      this.detailsStatus = Status.initial,
      this.creditsStatus = Status.initial,
      this.reviewsStatus = Status.initial,
      this.topRatedStatus = Status.initial,
      this.categoriesStatus = Status.initial,
      this.moviesStatue = Status.initial});

  HomeState copyWith({
    List<MovieModel>? topRated,
    List<MovieModel>? movies,
    List<GenreModel>? genres,
    List<Cast>? cast,
    List<ReviewModel>? review,
    MovieDetailsResponseModel? movieDetails,
    Status? detailsStatus,
    Status? creditsStatus,
    Status? reviewsStatus,
    Status? topRatedStatus,
    Status? categoriesStatus,
    Status? moviesStatue,
  }) {
    return HomeState(
      topRatedStatus: topRatedStatus ?? this.topRatedStatus,
      moviesStatue: moviesStatue ?? this.moviesStatue,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      creditsStatus: creditsStatus ?? this.creditsStatus,
      detailsStatus: detailsStatus ?? this.detailsStatus,
      reviewsStatus: reviewsStatus ?? this.reviewsStatus,
      cast: cast ?? this.cast,
      review: review ?? this.review,
      movieDetails: movieDetails ?? this.movieDetails,
      movies: movies ?? this.movies,
      genres: genres ?? this.genres,
      topRated: topRated ?? this.topRated,
    );
  }
}
