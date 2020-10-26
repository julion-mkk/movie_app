import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/repository/movieRepository.dart';
import 'package:rxdart/rxdart.dart';

class GenreListBloc {
    final MovieRepository _repository= MovieRepository();
    final BehaviorSubject<GenreResponse> _subject = BehaviorSubject<GenreResponse>();

    getGenres() async {
        GenreResponse response = await _repository.getGernes();
        _subject.sink.add(response);
    }

    dispose() {
        _subject.close();
    }

    BehaviorSubject<GenreResponse> get subject => _subject;
}

final genreBloc = GenreListBloc();