import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/bloc/getPersonBloc.dart';
import 'package:movie_app/model/person.dart';
import 'package:movie_app/model/person_response.dart';
import 'package:movie_app/style/theme.dart' as style;

import 'loadingWidget.dart';
class Persons extends StatefulWidget {
    _PersonsState createState()=> _PersonsState();
}

class _PersonsState extends State<Persons> {
    @override
    void initState() {
        super.initState();
        personBloc..getPersons();
    }

    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 10.0,top: 10.0),
                    child: Text("TRENDING PERSONS ON THIS WEEK",style: TextStyle(
                        color: style.Colors.titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                    ),
                ),
                SizedBox(
                    height: 5.0,
                ),
                StreamBuilder<PersonResponse>(
                    stream: personBloc.subject.stream,
                    builder: (context,AsyncSnapshot<PersonResponse> snapshot) {
                        if(snapshot.hasData) {
                            if(snapshot.data.error != null && snapshot.data.error.length > 0)
                                return ErrorWidget(snapshot.data.error);
                            return _buildPersonsWidget(snapshot.data);
                        } else if(snapshot.hasError) {
                            return ErrorWidget(snapshot.error);
                        }
                        return Container();
                        //return LoadingWidget();
                    },
                )
            ],
        );
    }

    _buildPersonsWidget(PersonResponse data) {
        List<Person> persons = data.persons;
        if(persons.length == 0) {
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
                height: 130.0,
                padding: EdgeInsets.only(left: 10.0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: persons.length,
                    itemBuilder: (context, index) {
                        return Container(
                            width: 100,
                            padding: EdgeInsets.only(top: 10.0,right: 10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    persons[index].profileImg == null ?
                                        Container(
                                            width: 70.0,
                                            height: 70.0,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: style.Colors.secondColor,
                                            ),
                                            child: Icon(FontAwesomeIcons.userAlt, color: Colors.white,),
                                        ) :
                                        Container(
                                            width: 70.0,
                                            height: 70.0,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w200/" + persons[index].profileImg),fit: BoxFit.cover)
                                            ),
                                        ),
                                    SizedBox(
                                        height: 10.0,
                                    ),
                                    Text(persons[index].name,maxLines: 2, style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.0,
                                        height: 1.4,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    SizedBox(
                                        height: 5.0,
                                    ),
                                    Text("Trending for ${persons[index].known}",style: TextStyle(
                                        color: style.Colors.titleColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 6.0
                                    ),)
                                ],
                            ),
                        );
                    },
                ),
            );
        }
    }
}