import 'package:movizone/core/unified_api/api_variables.dart';
import 'package:movizone/core/unified_api/get_api.dart';

import '../model/credits_model.dart';
import '../model/movie_details_model.dart';
import '../model/reviews_model.dart';

class DetaditsDatasourec {
  Future<MovieReviewsResponseModel> getReviews(String movieId) async {
    final result = GetApi(
      uri: ApiVariables().getMovieReview(movieId),
      fromJson: movieReviewsResponseModelFromJson,);
    return await result.callRequest();
  }

  Future<MovieCreditsResponseModel> getCredits(String movieId) async {
    final result = GetApi(
      uri: ApiVariables().getMovieCredits(movieId),
      fromJson: movieCreditsResponseModelFromJson,
    );
    return await result.callRequest();
  }

  Future<MovieDetailsResponseModel> getDeatils(String movieId) async {
    final result = GetApi(
      uri: ApiVariables().getMovieDetails(movieId),
      fromJson: movieDetailsResponseModelFromJson,
    );
    return await result.callRequest();
  }
}
