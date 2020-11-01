import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/getMovieByGenre.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/style/theme.dart' as style;
import 'package:movie_app/widgets/genresMovies.dart';

class GenreList extends StatefulWidget {
    final List<Genre> genres;
    GenreList({Key key, @required this.genres}): super(key: key);
    _GenreListState createState()=> _GenreListState(genres);
}

class _GenreListState extends State<GenreList> with SingleTickerProviderStateMixin {
    final List<Genre> genres;
    _GenreListState(this.genres);

    TabController _tabController;

    @override
    void initState() {
        super.initState();
        _tabController = TabController(vsync: this, length: genres.length);
        _tabController.addListener(() {
            if(_tabController.indexIsChanging) {
                movieListByGenre..drainStream();
            }
        });
    }

    @override
    void dispose() {
        super.dispose();
        _tabController.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            height: 307,
            child: DefaultTabController(
                length: genres.length,
                child: Scaffold(
                    backgroundColor: style.Colors.mainColor,
                    appBar: PreferredSize(
                        preferredSize: Size.fromHeight(50.0),
                        child: AppBar(
                            backgroundColor: style.Colors.mainColor,
                            bottom: TabBar(
                                controller: _tabController,
                                indicatorColor: style.Colors.secondColor,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorWeight: 3.0,
                                unselectedLabelColor: style.Colors.titleColor,
                                labelColor: Colors.white,
                                isScrollable: true,
                                tabs: genres.map((Genre genre) {
                                    return Container(
                                        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                                        child: Text(genre.name.toUpperCase(), style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                        ),)
                                    );
                                }).toList(),
                            ),
                        ),
                    ),
                    body: TabBarView(
                        controller: _tabController,
                        physics: NeverScrollableScrollPhysics(),
                        children: genres.map((Genre genre) {
                            return GenreMovies(genreId: genre.id);
                        }).toList(),
                    ),
                ),
            ),
        );
    }
}