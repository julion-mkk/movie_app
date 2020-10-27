import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/style/theme.dart' as style;
import 'package:movie_app/widgets/nowPlaying.dart';

class HomeScreen extends StatefulWidget{
    HomeScreenState createState()=> HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: style.Colors.mainColor,
            appBar: AppBar(
                centerTitle: true,
                backgroundColor: style.Colors.mainColor,
                title: Text("MovieApp"),
                leading: Icon(EvaIcons.menu2Outline, color: Colors.white,),
                actions: [
                    IconButton(icon: Icon(EvaIcons.searchOutline, color: Colors.white,),onPressed: null,)
                ],
            ),
            body: ListView(
                children: <Widget>[
                    NowPlaying()
                ],
            ),
        );
    }
}