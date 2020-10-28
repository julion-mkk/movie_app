import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/getGenreBloc.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/widgets/genresList.dart';
import 'package:movie_app/widgets/loadingWidget.dart';

class GenresScreen extends StatefulWidget {
    _GenresScreenState createState()=> _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
    @override
    void initState() {
        super.initState();
        genreBloc..getGenres();

    }
    Widget build(BuildContext context) {
        return StreamBuilder<GenreResponse>(
            stream: genreBloc.subject.stream,
            builder: (context,AsyncSnapshot<GenreResponse> snapshot) {
                if(snapshot.hasData) {
                    if(snapshot.data.error != null && snapshot.data.error.length > 0)
                        return ErrorWidget(snapshot.data.error);
                    return _buildGenresWidget(snapshot.data);
                } else if(snapshot.hasError) {
                    return ErrorWidget(snapshot.error);
                }
                return LoadingWidget();
            },
        );
    }

    _buildGenresWidget(GenreResponse data) {
        List<Genre> genres = data.genres;
        print("genresFrom : $genres");
        if(genres.length == 0) {
            return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Text("No genres")
                    ],
                ),
            );
        } else {
            print("genresSSS : $genres");
            return GenreList(genres: genres);
        }
    }
}