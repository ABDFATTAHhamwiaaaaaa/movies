part of 'search_bloc.dart';

abstract class SearchEvent {}


class searchMovieEvent extends SearchEvent{

  final String query;

  searchMovieEvent({required this.query});


}