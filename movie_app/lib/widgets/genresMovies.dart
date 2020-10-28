import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/getMovieByGenre.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/style/theme.dart' as style;

import 'loadingWidget.dart';

class GenreMovies extends StatefulWidget {
    final int genreId;
    GenreMovies({Key key,@required this.genreId}) : super(key: key);
    _GenreMoviesState createState()=> _GenreMoviesState(genreId);
}

class _GenreMoviesState extends State<GenreMovies> {
    final int genreId;

    @override
    void initState()
    {
        super.initState();
        movieListByGenre..getMovieByGenre(genreId);
    }
    _GenreMoviesState(this.genreId);
    Widget build(BuildContext context) {
        return StreamBuilder<MovieResponse>(
            stream: movieListByGenre.subject.stream,
            builder: (context,AsyncSnapshot<MovieResponse> snapshot) {
                if(snapshot.hasData) {
                    if(snapshot.data.error != null && snapshot.data.error.length > 0)
                        return ErrorWidget(snapshot.data.error);
                    return _buildMoviesByGenresWidget(snapshot.data);
                } else if(snapshot.hasError) {
                    return ErrorWidget(snapshot.error);
                }
                return LoadingWidget();
            },
        );
    }
    _buildMoviesByGenresWidget(MovieResponse data) {
        List<Movie> movies = data.movies;
        if(movies.length == 0) {
            return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Text("No movies")
                    ],
                ),
            );
        } else {
            return Container(
                height: 270.0,
                padding: EdgeInsets.only(left: 10.0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context,index) {
                        return Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                            child: Column(
                                children: [
                                    movies[index].poster == null ? Container(
                                            width: 120,
                                            height: 180,
                                            decoration: BoxDecoration(
                                                color: Colors.yellow,
                                                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                                shape: BoxShape.rectangle,
                                            ),
                                            child: Column(
                                                children: <Widget>[
                                                    Icon(EvaIcons.filmOutline, color: Colors.white, size: 50.0,)
                                                ],
                                            ),
                                    ) :
                                    Container(
                                        width: 120.0,
                                        height: 180.0,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                                            shape: BoxShape.rectangle,
                                            image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w200/" + movies[index].poster),fit: BoxFit.cover)
                                        ),
                                    ),
                                    SizedBox(
                                        height: 10.0,
                                    ),
                                    Container(
                                        width: 100,
                                        child: Text(movies[index].title,maxLines: 2, style: TextStyle(
                                            height: 1.2,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11.0
                                        ),),
                                    ),
                                    SizedBox(
                                        height: 5.0,
                                    ),
                                    Row(
                                        children: <Widget>[
                                            Text(movies[index].rating.toString(), style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.bold,),
                                            ),
                                            SizedBox(
                                                width: 5.0,
                                            ),
                                            RatingBar(
                                                itemSize: 8.0,
                                                initialRating: movies[index].rating / 2,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                                itemBuilder: (context,_) {
                                                    return Icon(EvaIcons.star,color: style.Colors.secondColor,);
                                                },
                                                onRatingUpdate: (rating) {
                                                    print(rating);
                                                },
                                            )
                                        ],
                                    )
                                ],
                            ),
                        );
                    },
                ),
            );
        }
    }

}