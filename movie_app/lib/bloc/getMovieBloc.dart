import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repository/movieRepository.dart';
import 'package:rxdart/rxdart.dart';

class MovieListBloc {
    final MovieRepository _repository= MovieRepository();
    final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

    getMovies() async {
        MovieResponse response = await _repository.getMovies();
        _subject.sink.add(response);
    }

    dispose() {
        _subject.close();
    }

    BehaviorSubject<MovieResponse> get subject => _subject;
}

final movieBloc = MovieListBloc();