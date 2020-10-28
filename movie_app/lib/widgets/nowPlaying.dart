import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/bloc/getNowPlayingBloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/widgets/loadingWidget.dart';
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
                        return ErrorWidget(snapshot.data.error);
                    return _buildNowPlayingWidget(snapshot.data);
                } else if(snapshot.hasError) {
                    return ErrorWidget(snapshot.error);
                }
                return LoadingWidget();
            },
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
                    shape: IndicatorShape.circle(size: 5.0),
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
                                            image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original/" + movies[index].backPoster),
                                            fit: BoxFit.cover)
                                        ),
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                    style.Colors.mainColor.withOpacity(1.0),
                                                    style.Colors.mainColor.withOpacity(0.0)
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                stops: [
                                                    0.0,
                                                    0.9
                                                ]
                                            )
                                        ),
                                    ),
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        top: 0,
                                        bottom: 0,
                                        child: Icon(FontAwesomeIcons.playCircle,color: style.Colors.secondColor,size: 40.0,),
                                    ),
                                    Positioned(
                                        bottom: 30,
                                        child: Container(
                                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                            width: 250,
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                    Text(movies[index].title,style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        height: 1.5,
                                                        fontSize: 16
                                                    ),)
                                                ],
                                            ),
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