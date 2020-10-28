import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
    Widget build(BuildContext context) {
        return Container(
            child: Center(
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
            ),
        );
    }
}