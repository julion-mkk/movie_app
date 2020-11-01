import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/cast_response.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/repository/movieRepository.dart';
import 'package:rxdart/rxdart.dart';

class GetCastBloc {
    final MovieRepository _repository= MovieRepository();
    final BehaviorSubject<CastResponse> _subject = BehaviorSubject<CastResponse>();

    getCasts(id) async {
        CastResponse response = await _repository.getCasts(id);
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

    BehaviorSubject<CastResponse> get subject => _subject;
}

final getCastBloc = GetCastBloc();