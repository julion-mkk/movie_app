import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/getCastBloc.dart';
import 'package:movie_app/model/cast.dart';
import 'package:movie_app/model/cast_response.dart';
import 'package:movie_app/style/theme.dart' as style;
import 'package:movie_app/widgets/loadingWidget.dart';

class Casts extends StatefulWidget {
    final int movieId;
    Casts({Key key, @required this.movieId}) : super(key:  key);
    _CastsState createState()=> _CastsState(this.movieId);
}

class _CastsState extends State<Casts> {
    final int movieId;
    _CastsState(this.movieId);

    @override
    void initState() {
        super.initState();
        getCastBloc..getCasts(this.movieId);
    }

    @override
    void dispose() {
        super.dispose();
        getCastBloc..drainStream();
    }

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 20.0),
                    child: Text("CASTS",style: TextStyle(
                        color: style.Colors.titleColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                    ),
                ),
                SizedBox(
                    height: 10.0,
                ),
                StreamBuilder<CastResponse>(
                    stream: getCastBloc.subject.stream,
                    builder: (context,AsyncSnapshot<CastResponse> snapShot) {
                        if(snapShot.hasData) {
                            if(snapShot.data.error != null && snapShot.data.error.length > 0) {
                                return ErrorWidget(snapShot.data.error);
                            }
                            print("CSASS: ${snapShot.data.casts[8].img}");
                            return _buildCastsWidget(snapShot.data);
                        } else if(snapShot.hasError) {
                            return ErrorWidget(snapShot.error);
                        }
                        return LoadingWidget();
                    },
                )
            ],
        );
    }

    _buildCastsWidget(CastResponse data) {
        List<Cast> casts = data.casts;
        return Container(
            height: 140.0,
            padding: EdgeInsets.only(left: 10),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: casts.length,
                itemBuilder: (context,index) {
                    return Container(
                        padding: EdgeInsets.only(top: 10, right: 10),
                        width: 100,
                        child: GestureDetector(
                            onTap: () {

                            },
                            child: Column(
                                children: <Widget>[
                                    Container(
                                        width: 70,
                                        height: 70,
                                        decoration:casts[index].img != null? BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w300/" + casts[index].img),fit: BoxFit.cover)
                                        ) : BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black.withOpacity(0.8)
                                        ),
                                    ),
                                    SizedBox(
                                        height: 10.0,
                                    ),
                                    Text(casts[index].name,maxLines: 2, textAlign: TextAlign.center, style: TextStyle(
                                        height: 1.4,
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,),
                                    ),
                                    SizedBox(
                                        height: 10.0,
                                    ),
                                    Text(casts[index].character, style: TextStyle(
                                        fontSize: 7.0,
                                        fontWeight: FontWeight.bold,
                                        color:style.Colors.titleColor,),
                                    )
                                ],
                            ),
                        ),
                    );
                },
            ),
        );
    }
}