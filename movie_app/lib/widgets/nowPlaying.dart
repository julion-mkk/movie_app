import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/getNowPlayingBloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:movie_app/style/theme.dart' as style;

class NowPlaying extends StatefulWidget {
    NowPlayingState createState()=> NowPlayingState();
}

class NowPlayingState extends State<NowPlaying> {

    @override
    void initState() {
        super.initState();
        nowPlayingMovies..getPlayingMovies();
    }


    Widget build(BuildContext context) {
        return StreamBuilder<MovieResponse>(
            stream: nowPlayingMovies.subject.stream,
            builder: (context,AsyncSnapshot<MovieResponse> snapshot) {
                if(snapshot.hasData) {
                    if(snapshot.data.error != null && snapshot.data.error.length > 0)
                        return _buildErrorWidget(snapshot.data.error);
                    return _buildNowPlayingWidget(snapshot.data);
                } else if(snapshot.hasError) {
                    return _buildErrorWidget(snapshot.error);
                }
                return _buildLoadingWidget();
            },
        );
    }

    _buildErrorWidget(String error) {
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Text(error)
                ],
            ),
        );
    }

    _buildLoadingWidget() {
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    SizedBox(
                        height: 25.0,
                        width: 25.0,
                        child: CircularProgressIndicator(),
                    )
                ],
            )
        );
    }

    _buildNowPlayingWidget(MovieResponse data) {
        List<Movie> movies= data.movies;
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
                height: 220.0,
                child: PageIndicatorContainer(
                    align: IndicatorAlign.bottom,
                    indicatorSpace: 8.0,
                    padding: EdgeInsets.all(5.0),
                    length: movies.take(5).length,
                    indicatorColor: style.Colors.titleColor,
                    indicatorSelectorColor: style.Colors.secondColor,
                    pageView: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.take(5).length,
                        itemBuilder: (context,index) {
                            return Stack(
                                children: <Widget>[
                                    Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 220.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original/" + movies[index].backPoster))
                                        ),
                                    )
                                ],
                            );
                        },
                    ),
                ),
            );
        }
    }
}