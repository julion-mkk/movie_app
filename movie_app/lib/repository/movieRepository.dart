import 'package:dio/dio.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/model/person.dart';
import 'package:movie_app/model/person_response.dart';

class MovieRepository {
    final String apiKey = "44accb5aeb17aac8c9c8f0d576a76b9d";
    static String mainUrl = "https://api.themovedb.com/3";
    final Dio _dio = Dio();
    var getPopularUrl = "$mainUrl/movie/top_rated";
    var getMovieUrl = "$mainUrl/discover/movie";
    var getPlayingUrl = "$mainUrl/movie/now_playing";
    var getGenresUrl = "$mainUrl/genre/movie/list";
    var getPersonsUrl = "$mainUrl/trending/person/week";

    Future<MovieResponse> getMovies() async {
        var params= {
            "api_key" : apiKey,
            "language" : "en-US",
            "page" : 1
        };
        try {
            Response response = await _dio.get(getPopularUrl, queryParameters: params);
            return MovieResponse.fromJson(response.data);
        }catch(error, stacktrace) {
            print("Exception occured: $error stackTrace: $stacktrace");
            return MovieResponse.withError("$error");
        }
    }

    Future<MovieResponse> getPlayingMovies() async {
        var params= {
            "api_key" : apiKey,
            "language" : "en-US",
            "page" : 1
        };
        try {
            Response response = await _dio.get(getPlayingUrl, queryParameters: params);
            return MovieResponse.fromJson(response.data);
        }catch(error, stacktrace) {
            print("Exception occured: $error stackTrace: $stacktrace");
            return MovieResponse.withError("$error");
        }
    }

    Future<GenreResponse> getGernes() async {
        var params= {
            "api_key" : apiKey,
            "language" : "en-US",
            "page" : 1
        };
        try {
            Response response = await _dio.get(getGenresUrl, queryParameters: params);
            return GenreResponse.fromJson(response.data);
        }catch(error, stacktrace) {
            print("Exception occured: $error stackTrace: $stacktrace");
            return GenreResponse.withError("$error");
        }
    }

    Future<PersonResponse> getPersons() async {
        var params= {
            "api_key" : apiKey
        };
        try {
            Response response = await _dio.get(getPersonsUrl, queryParameters: params);
            return PersonResponse.fromJson(response.data);
        }catch(error, stacktrace) {
            print("Exception occured: $error stackTrace: $stacktrace");
            return PersonResponse.withError("$error");
        }
    }

    Future<MovieResponse> getMovieByGenre(int id) async {
        var params= {
            "api_key" : apiKey,
            "language" : "en-US",
            "page" : 1,
            "with_genres" : id
        };
        try {
            Response response = await _dio.get(getMovieUrl, queryParameters: params);
            return MovieResponse.fromJson(response.data);
        }catch(error, stacktrace) {
            print("Exception occured: $error stackTrace: $stacktrace");
            return MovieResponse.withError("$error");
        }
    }
}