part of 'search_bloc.dart';

class SearchState {
  final Status status;
  final List<MovieSearchModel> sreachResult;

  SearchState({
    this.status = Status.initial,
    this.sreachResult = const [],
  });

  SearchState copyWith({Status? statue, List<MovieSearchModel>? reachResult}) {
    return SearchState(
      status: status ?? this.status,
      sreachResult: reachResult ?? this.sreachResult,
    );
  }
}
