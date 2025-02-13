// class ApiVariables {
//   final _scheme = 'https';
//   final _host = 'api.themoviedb.org';
//
//   final port = 8000;
//   final imageBaseUrl = 'https://image.tmdb.org/t/p/w200';
//   Uri _mainUri(String path, {Map<String, String>? params}) {
//     return Uri(
//       host: _host,
//       scheme: _scheme,
//       path: path,
//       queryParameters: {'api_key': ''}..addAll(params ?? {}),
//     );
//   }
//
//   Uri getPopular() => _mainUri('/3/movie/popular');
//   Uri getCategories() => _mainUri('/3/genre/movie/list');
//   Uri getMovie(Map<String, String> params) =>
//       _mainUri('/3/discover/movie', params: params);
//   Uri getMovieDetails(String movieId) => _mainUri(
//         '/3/movie/$movieId',
//       );
//   Uri getMovieCredits(String movieId) => _mainUri(
//         '/3/movie/$movieId/credits',
//       );
//   Uri getMovieReviews(String movieId) => _mainUri(
//         '/3/movie/$movieId/reviews',
//       );
//   Uri search(Map<String, String> params) =>
//       _mainUri('/3/search/movie', params: params);
// }

class ApiVariables {
  final _sheme = 'https';
  final _host = 'api.themoviedb.org';

  final pord = 8000;

  final  imageBaseUrl = 'https://image.tmdb.org/t/p/w200';

  Uri _mainUri(String path, {Map<String, String>? params}) {
    return Uri(
      host: _host,
      path: path,
      scheme: _sheme,
      queryParameters: {'api_key': ''}..addAll(params ?? {}),
    );
  }

  Uri getPopular() => _mainUri('/3/movie/popular');

  Uri getCategories() => _mainUri('/3/genre/movie/list');

  Uri getMovie(Map<String, String>? params ) =>
      _mainUri('/3/discover/movie', params: params);

  Uri getMovieDetails(String movieId ) =>
      _mainUri('/3/discover/movie/$movieId');

  Uri getMovieCredits(String movieId ) =>
      _mainUri('/3/discover/movie/$movieId/credits');

  Uri getMovieReview(String movieId) =>
      _mainUri('/3/discover/movie/$movieId/reviews');

  Uri search(Map<String,String> params) =>
      _mainUri('/3/search/movie', params: params);
}
