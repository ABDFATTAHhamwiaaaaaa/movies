import 'package:movizone/core/unified_api/api_variables.dart';
import 'package:movizone/core/unified_api/get_api.dart';

import '../model/search_model.dart';

class SearchdataSource {


  Future<SearchResponseModel> searchMovie(Map<String, String> params)async {
    final result = GetApi(uri: ApiVariables().search(params),
        fromJson: searchResponseModelFromJson);
    return await  result.callRequest();
  }


}