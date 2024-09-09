import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../core/unified_api/status.dart';
import '../../home/data/model/movie_details_model.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistState()) {
    on<GetWishlistEvent>((event, emit) {
      emit(state.copyWith(
        wishlistMovie:
            Hive.box<MovieDetailsResponseModel>('wishlist').values.toList(),
      ));
    });
    on<AddWishlistEvent>((event, emit) async {
      await Hive.box<MovieDetailsResponseModel>('wishlist')
          .put(event.movie.id, event.movie);
      add(GetWishlistEvent());
    });
    on<RemoveWishlistEvent>((event, emit) async {
      await Hive.box<MovieDetailsResponseModel>('wishlist').delete(event.id);
      add(GetWishlistEvent());
    });
  }
}
