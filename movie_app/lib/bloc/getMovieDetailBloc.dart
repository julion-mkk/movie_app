import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/movieDetail_response.dart';
import 'package:movie_app/repository/movieRepository.dart';
import 'package:rxdart/rxdart.dart';

class getMovieDetailBloc {
    final MovieRepository _repository = MovieRepository();
    final BehaviorSubject<MovieDetailResponse> _subject = BehaviorSubject<MovieDetailResponse>();

    getCasts(int id) async {
        MovieDetailResponse response = await _repository.getMovieDetail(id);
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

    BehaviorSubject<MovieDetailResponse> get cast => _subject;
}
final getCastBloc = getMovieDetailBloc();