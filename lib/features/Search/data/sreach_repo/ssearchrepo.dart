import 'package:dartz/dartz.dart';
import 'package:movizone/core/unified_api/failures.dart';
import 'package:movizone/core/unified_api/handling_exception_manager.dart';
import 'package:movizone/features/Search/data/search_data_sourec/searchdata.dart';

import '../model/search_model.dart';

class Searchrepo with HandlingExceptionManager {
  Future<Either<Failure, dynamic>> searchMovie(
      Map<String, String> params) async{
     return wrapHandling(tryCall: ()async{
       final ressult= await SearchdataSource().searchMovie(params);
       return  Right(ressult);
     });
  }
}
