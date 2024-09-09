part of 'home_bloc.dart';

abstract class HomeEvent {}

class GetTopRated extends HomeEvent{}
class Getcategories extends HomeEvent{}
class GetmoviesEvent extends HomeEvent{
  final String? genreid;

  GetmoviesEvent({ this.genreid});
}
class GetDetadilsEvent extends HomeEvent{

  final String movieId;

  GetDetadilsEvent( this.movieId);


}
class GetCreditsEvent extends HomeEvent{

  final String movieId;

  GetCreditsEvent( this.movieId);


}
class GetReviwesEvent extends HomeEvent{

  final String movieId;

  GetReviwesEvent( this.movieId);


}

