import 'package:movie_app/model/genre.dart';

class MovieDetail {
    final int id;
    final int budget;
    final bool isAdult;
    final List<Genre> genres;
    final String releaseDate;
    final int runtime;

    MovieDetail(this.id,this.budget,this.isAdult,this.genres,this.releaseDate,this.runtime);

    MovieDetail.formJson(Map<String,dynamic> json) :
        id = json["id"],
        budget = json["budget"],
        isAdult = json["adult"],
        genres = (json["genres"] as List).map((i)=> new Genre.fromJson(i)).toList(),
        runtime = json["runtime"],
        releaseDate = json["release_date"];
}