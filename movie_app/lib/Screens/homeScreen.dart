import 'package:flutter/material.dart';
import 'package:movie_app/style/theme.dart' as style;

class HomeScreen extends StatefulWidget{
    HomeScreenState createState()=> HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: style.Colors.mainColor,
        );
    }
}