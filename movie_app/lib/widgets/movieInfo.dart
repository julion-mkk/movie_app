import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/getMovieDetailBloc.dart';
import 'package:movie_app/model/movieDetail.dart';
import 'package:movie_app/model/movieDetail_response.dart';
import 'package:movie_app/style/theme.dart' as style;

import 'loadingWidget.dart';

class MovieInfo extends StatefulWidget {
    final int movieId;
    MovieInfo({Key key, @required this.movieId}) : super(key: key);
    _MovieInfoState createState()=> _MovieInfoState(movieId);
}

class _MovieInfoState extends State<MovieInfo> {
    final int movieId;
    _MovieInfoState(this.movieId);

    @override
    void initState() {
        super.initState();
        print(movieId);
        getMovieDetailBloc..getMovieDetail(movieId);
    }

    @override
    void dispose() {
        super.dispose();
        getMovieDetailBloc..drainStream();
    }

    @override
    Widget build(BuildContext context) {
        return StreamBuilder<MovieDetailResponse>(
            stream:getMovieDetailBloc.subject.stream,
            builder: (context,AsyncSnapshot<MovieDetailResponse> snapshot) {
            if(snapshot.hasData) {
                if(snapshot.data.error != null && snapshot.data.error.length > 0) {
                    return ErrorWidget(snapshot.data.error);
                }
                return _buildMovieDetailWidget(snapshot.data);
            } else if(snapshot.hasError) {
                return ErrorWidget(snapshot.error);
            }
            return LoadingWidget();
        });
    }

    _buildMovieDetailWidget(MovieDetailResponse data) {
        MovieDetail movieDetail = data.movieDetail;
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text("BUDGET", style: TextStyle(
                                        color: style.Colors.titleColor,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,),
                                    ),
                                    SizedBox(
                                        height: 10.0,
                                    ),
                                    Text(
                                        movieDetail.budget.toString() + "\$",style: TextStyle(
                                        color: style.Colors.secondColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                    )
                                ],
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text("DURATION", style: TextStyle(
                                        color: style.Colors.titleColor,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,),
                                    ),
                                    SizedBox(
                                        height: 10.0,
                                    ),
                                    Text(
                                        movieDetail.runtime.toString() + "min",style: TextStyle(
                                        color: style.Colors.secondColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                    )
                                ],
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text("RELEASE DATE", style: TextStyle(
                                        color: style.Colors.titleColor,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,),
                                    ),
                                    SizedBox(
                                        height: 10.0,
                                    ),
                                    Text(
                                        movieDetail.releaseDate,style: TextStyle(
                                        color: style.Colors.secondColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                    )
                                ],
                            ),
                        ],
                    ),
                ),
                SizedBox(
                    height: 10.0,
                )
            ],
        );
    }
}