import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/model/video_response.dart';
import 'package:movie_app/repository/movieRepository.dart';
import 'package:rxdart/rxdart.dart';

class GetSimilarMoviesBloc {
    final MovieRepository _repository = MovieRepository();
    final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

    getCasts(int id) async {
        MovieResponse response = await _repository.getSimilarMovies(id);
        _subject.sink.add(response);
    }

    void drainStream() {
        _subject.value = null;
    }
    @mustCallSuper
    void dispose() async {
        await _subject.drain();
        _subject.close();
    }

    BehaviorSubject<MovieResponse> get subject => _subject;
}
final getSimilarMoviesBloc = MovieRepository();