
import 'package:movies_app/models/models.dart';

class PopularResponse {

  int? page, totalPages, totalResults;
  List<Movie> results;

  PopularResponse({ required this.page, required this.results, required this.totalPages, required this.totalResults });

  factory PopularResponse.fromJson(String str) => PopularResponse.fromMap(json.decode(str));

  factory PopularResponse.fromMap(Map<String, dynamic> json) => PopularResponse(
    page: json["page"],
    results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

}
