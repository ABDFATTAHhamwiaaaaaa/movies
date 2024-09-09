import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movizone/features/Search/data/sreach_repo/ssearchrepo.dart';

import '../../../core/unified_api/status.dart';
import '../data/model/search_model.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<searchMovieEvent>((event, emit) async {
      emit(state.copyWith(statue: Status.loading));
      final result = await Searchrepo().searchMovie({'query': event.query});
      result.fold((L) => emit(state.copyWith(statue: Status.failed)),
          (R) => emit(state.copyWith(statue: Status.success)));
    });
  }
}
