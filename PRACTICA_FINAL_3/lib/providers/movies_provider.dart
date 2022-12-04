import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import '../models/movie.dart';

//Logica proveer peliulas, ChangeNotifier, avisar a cambio
class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org',
      _apiKey = 'e1ef5a12528a75d741c0768e8e352a3a',
      _language = 'es-ES',
      _page = '1';
  List<Movie> onDisplayMovies = [];
  List<Movie> onDisplayPopulars = [];
  Map<int, List<Cast>> casting = {};


  MoviesProvider() {
    getOnDisplayMovies();
    getOnDisplayPopulars();
  }

//await obliga a declarar el metodo como asincrono se ejecutara ind. ejecucion Await the http get response, then decode the json-formatted response
  //dentro provider metodo avisar arbol de widgets que lo usan de que se comete cambio, Usamos notifyListeners();
  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});
    final result = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    var url = Uri.https(_baseUrl, '3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'language': _language});
    final result = await http.get(url);
    final creditsResponse = CreditsResponse.fromJson(result.body);
    casting[idMovie] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  getOnDisplayPopulars() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': _page});
    final result = await http.get(url);
    final popularResponse = PopularResponse.fromJson(result.body);
    onDisplayPopulars = popularResponse.results;
    notifyListeners();
  }
}
