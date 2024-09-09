part of 'wishlist_bloc.dart';

class WishlistEvent {}

class GetWishlistEvent extends WishlistEvent {}

class AddWishlistEvent extends WishlistEvent {
  final MovieDetailsResponseModel movie;

  AddWishlistEvent({required this.movie});
}

class RemoveWishlistEvent extends WishlistEvent {
  final int id;

  RemoveWishlistEvent({required this.id});
}
