import 'package:flutter/material.dart';
import 'package:movie_app/Screens/homeScreen.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
        );
    }
}