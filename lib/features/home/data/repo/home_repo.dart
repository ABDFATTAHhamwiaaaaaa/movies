import 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart';
import 'package:movizone/core/unified_api/failures.dart';
import 'package:movizone/core/unified_api/handling_exception_manager.dart';
import 'package:movizone/features/home/data/datasource/home_data.dart';
import 'package:movizone/features/home/data/datasource/home_data.dart';
import 'package:movizone/features/home/data/datasource/home_data.dart';
import 'package:movizone/features/home/data/model/genres_response_model.dart';
import 'package:movizone/features/home/data/model/top_rated_model.dart';
import 'package:movizone/features/home/data/model/top_rated_model.dart';
import 'package:movizone/features/home/data/model/top_rated_model.dart';

import '../datasource/detadits_datasourec.dart';
import '../model/credits_model.dart';
import '../model/movie_details_model.dart';
import '../model/reviews_model.dart';

class HomeRepo with HandlingExceptionManager {
  Future<Either<Failure, GenresResponseModel>> getGenres() async {
    return await wrapHandling(
      tryCall: () async {
        final reesult = await HomeDataSource().getGenres();
        return Right(reesult);
      },
    );
  }

  Future<Either<Failure, TopRatedResponseModel>> getTopRatedasync() async {
    return await wrapHandling(
      tryCall: () async {
        final reesult = await HomeDataSource().getTopRated();
        return Right(reesult);
      },
    );
  }

  Future<Either<Failure, TopRatedResponseModel>> getMovies(String? genreId) async {
    return await wrapHandling(
      tryCall: () async {
        final reesult = await HomeDataSource().getMovies(genreId);
        return Right(reesult);
      },
    );
  }

  Future<Either<Failure,MovieDetailsResponseModel>> getDetails( String movieId)async{

    return await wrapHandling(tryCall: ()async{
      final result= await DetaditsDatasourec().getDeatils(movieId);
      return Right(result);
    });

  }

  Future<Either<Failure,MovieCreditsResponseModel>> getCredits( String movieId)async{

    return await wrapHandling(tryCall: ()async{
      final result= await DetaditsDatasourec().getCredits(movieId);
      return Right(result);
    });

  }

  Future<Either<Failure,MovieReviewsResponseModel>> getReviews( String movieId)async{

    return await wrapHandling(tryCall: ()async{
      final result= await DetaditsDatasourec().getReviews(movieId);
      return Right(result);
    });

  }



}
