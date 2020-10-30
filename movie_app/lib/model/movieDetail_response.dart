import 'package:movie_app/model/movieDetail.dart';

class MovieDetailResponse {
    final MovieDetail movieDetail;
    final String error;

    MovieDetailResponse(this.movieDetail,this.error);

    MovieDetailResponse.fromJson(Map<String,dynamic> json) : movieDetail = MovieDetail.formJson(json), error ="";

    MovieDetailResponse.withError(String errorValue) : movieDetail = MovieDetail(null, null, null, null, "", null) , error = errorValue;
}