import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterlab3/Models/MoviesPojo.dart';
import 'package:flutterlab3/Models/genre.dart';
import 'package:flutterlab3/blocs/MovieBloc.dart';

import 'DetailsScreen.dart';

class MyListMoviePage extends StatefulWidget {
  @override
  _MyListMoviePageState createState() => _MyListMoviePageState();
}

class _MyListMoviePageState extends State<MyListMoviePage> {
  MovieBloc mobj = MovieBloc();
  List<Genre> genres = List<Genre>();

  void initState() {
    super.initState();
    MovieBloc().getGenresFromRepo().then((result) {
      genres = result;
      print("From the init ");
      print(genres);
    });
  }

  String getGenreName(int id) {
    Genre g = genres.firstWhere((item) => item.id == id);
    return g.name;
  }

  // int idd;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movie List'),
        ),
        body: FutureBuilder(
          future: mobj.singleMovieDisplay(),
          builder: (_, AsyncSnapshot<List<MoviesPojo>> result) {
            if (result.hasData) {
              return ListView.builder(
                itemCount: result.data.length,
                itemBuilder: (_, i) {
                  List<String> genreNames = List<String>.from(result
                      .data[i].genreIds
                      .map((jsonEntry) => getGenreName(jsonEntry)));
                  //int idd = result.data[i].id;
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              print("movie id is printed");
                              print(result.data[i].id);
                              return DetailsScreen(result.data[i].id);
                            },
                          ),
                        );
                      },
                      subtitle: Text("${result.data[i].overview}",
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.8))),
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              "${result.data[i].originalTitle}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text(
                              "${result.data[i].releaseDate}",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.indigo,
                              ),
                            ),
                            Wrap(
                              children: <Widget>[
                                for (var item in genreNames)
                                  Container(
                                    child: Text(
                                      '  ${item}',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        border: Border.all(
                                            width: 3.0,
                                            color: Colors.blueAccent)),
                                    padding: EdgeInsets.all(3.0),
                                  )
                              ],
                            )
                          ]),
                      leading: Image.network(
                        "https://image.tmdb.org/t/p/w185/" +
                            result.data[i].posterPath,
                      ),
                      trailing: Text("Rating:  ${result.data[i].voteAverage}"),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

//  void _moveToDetails() {
//    Navigator.of(context).push(
//      MaterialPageRoute<void>(
//        builder: (BuildContext context) {
//          print("movie id is printed");
//          print(idd);
//          return DetailsScreen(idd);
//        },
//      ),
//    );
//  }

}
