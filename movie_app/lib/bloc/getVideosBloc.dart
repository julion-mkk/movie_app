import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/movieDetail_response.dart';
import 'package:movie_app/model/video_response.dart';
import 'package:movie_app/repository/movieRepository.dart';
import 'package:rxdart/rxdart.dart';

class getVideosBloc {
    final MovieRepository _repository = MovieRepository();
    final BehaviorSubject<VideoResponse> _subject = BehaviorSubject<VideoResponse>();

    getCasts(int id) async {
        VideoResponse response = await _repository.getMovieVideos(id);
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

    BehaviorSubject<VideoResponse> get cast => _subject;
}
final getCastBloc = getVideosBloc();