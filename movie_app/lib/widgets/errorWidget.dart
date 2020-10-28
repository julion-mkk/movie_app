import 'package:flutter/cupertino.dart';

class ErrorWidget extends StatelessWidget {
    final String error;
    ErrorWidget({this.error});

    Widget build(BuildContext context) {
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
}