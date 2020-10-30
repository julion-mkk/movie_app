import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/style/theme.dart' as style;

class DeatilScreen extends StatefulWidget {
    final Movie movie;
    DeatilScreen({Key key,@required this.movie}) : super(key: key);
    DetailScreenState createState()=> DetailScreenState(this.movie);
}

class DetailScreenState extends State<DeatilScreen> {
    final Movie movie;
    DetailScreenState(this.movie);
    Widget build(BuildContext context) {
        return Scaffold(

        );
    }
}