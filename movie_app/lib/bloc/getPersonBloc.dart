import 'package:movie_app/model/person_response.dart';
import 'package:movie_app/repository/movieRepository.dart';
import 'package:rxdart/rxdart.dart';

class PersonBloc {
    final MovieRepository _repository= MovieRepository();
    final BehaviorSubject<PersonResponse> _subject = BehaviorSubject<PersonResponse>();

    getPersons() async {
        PersonResponse response = await _repository.getPersons();
        _subject.sink.add(response);
    }

    dispose() {
        _subject.close();
    }

    BehaviorSubject<PersonResponse> get subject => _subject;
}

final personBloc = PersonBloc();