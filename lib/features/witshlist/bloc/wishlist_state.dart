part of 'wishlist_bloc.dart';

class WishlistState {
  final Status wishMovieStatus;
  final List<MovieDetailsResponseModel> wishlistMovie;

  WishlistState(
      {this.wishMovieStatus = Status.initial, this.wishlistMovie = const []});

  WishlistState copyWith(
      {Status? wishMovieStatus,
      List<MovieDetailsResponseModel>? wishlistMovie}) {
    return WishlistState(
      wishMovieStatus: wishMovieStatus ?? this.wishMovieStatus,
      wishlistMovie: wishlistMovie ?? this.wishlistMovie,
    );
  }
}
