import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/getVideosBloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/video_response.dart';
import 'package:movie_app/style/theme.dart' as style;
import 'package:movie_app/widgets/casts.dart';
import 'package:movie_app/widgets/loadingWidget.dart';
import 'package:movie_app/widgets/movieInfo.dart';
import 'package:movie_app/widgets/similarMovies.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:movie_app/model/Video.dart';

class DetailScreen extends StatefulWidget {
    final Movie movie;
    DetailScreen({Key key,@required this.movie}) : super(key: key);
    DetailScreenState createState()=> DetailScreenState(this.movie);
}

class DetailScreenState extends State<DetailScreen> {
    final Movie movie;
    DetailScreenState(this.movie);

    @override
    void initState() {
        super.initState();
        getVideosBloc..getMoviesVideos(movie.id);
    }

    @override
    void dispose(){
        super.dispose();
        getVideosBloc..drainStream();
    }
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: style.Colors.mainColor,
            body: Builder(
                builder: (context) {
                    return SliverFab(
                        floatingPosition: FloatingPosition(right: 20.0),
                        floatingWidget: StreamBuilder<VideoResponse>(
                            stream:getVideosBloc.subject.stream,
                            builder: (context,AsyncSnapshot<VideoResponse> snapshot) {
                                if(snapshot.hasData) {
                                    if(snapshot.data.error != null && snapshot.data.error.length > 0) {
                                        return ErrorWidget(snapshot.data.error);
                                    }
                                    return _buildVideoWidget(snapshot.data);
                                } else if(snapshot.hasError) {
                                    return ErrorWidget(snapshot.error);
                                }
                                return LoadingWidget();
                            }
                        ),
                        expandedHeight: 200.0,
                        slivers: [
                            SliverAppBar(
                                backgroundColor: style.Colors.secondColor,
                                expandedHeight: 200.0,
                                pinned: true,
                                flexibleSpace: FlexibleSpaceBar(
                                    title: Text(
                                        movie.title.length > 40 ? movie.title.substring(0,37) + "..." : movie.title, style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500),
                                    ),
                                    background: Stack(
                                        children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original/" + movie.backPoster),fit: BoxFit.cover)
                                                ),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.black.withOpacity(0.5),
                                                    ),
                                                ),
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment.bottomCenter,
                                                        end: Alignment.topCenter,
                                                        colors: [
                                                            Colors.black.withOpacity(0.9),
                                                            Colors.black.withOpacity(0.0)
                                                        ]

                                                    )
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                            ),
                            SliverPadding(
                                padding: EdgeInsets.all(0.0),
                                sliver: SliverList(
                                    delegate: SliverChildListDelegate(
                                        [
                                            Padding(
                                                padding: EdgeInsets.only(left: 10.0, top: 20.0),
                                                child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                        Text(
                                                            movie.rating.toString(),style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                        ),
                                                        SizedBox(
                                                            width: 5.0,
                                                        ),
                                                        RatingBar(
                                                            itemSize: 10.0,
                                                            initialRating: movie.rating / 2,
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
                                                        ),
                                                    ],
                                                ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 10.0, top: 20.0),
                                                child: Text("OVERVIEW",style: TextStyle(
                                                    color: style.Colors.titleColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.0
                                                ),),
                                            ),
                                            SizedBox(
                                                height: 5.0,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Text(movie.overview, style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    height: 1.5),
                                                ),
                                            ),
                                            SizedBox(
                                                height: 5.0,
                                            ),
                                            MovieInfo(movieId: movie.id),
                                            SizedBox(
                                                height: 10.0,
                                            ),
                                            Casts(movieId: movie.id),
                                            SizedBox(
                                                height: 10.0,
                                            ),
                                            SimilarMovies(movieId: movie.id)
                                        ]
                                    ),
                                ),
                            )
                        ],
                    );
                },
            ),
        );
    }

    _buildVideoWidget(VideoResponse data) {
        List<Video> videos = data.videos;
        return FloatingActionButton(
            backgroundColor: style.Colors.secondColor,
            child: Icon(Icons.play_arrow,),
            onPressed: () {  },
        );
    }
}