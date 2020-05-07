import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlab3/Models/DetailsPojo.dart';
import 'package:flutterlab3/Models/MoviesPojo.dart';
import 'package:flutterlab3/blocs/MovieBloc.dart';
import 'package:flutterlab3/ui/star_widget.dart';

class DetailsScreen extends StatelessWidget {
  MovieBloc m = MovieBloc();
  int id;
  DetailsScreen(this.id);
  Widget build(BuildContext context) {
    print("id from listscreen");
    print(id);
    return Scaffold(
      body: FutureBuilder(
        future: m.getMovieDetailsFromRepo(id),
        builder: (_, AsyncSnapshot<DetailsPojo> result) {
          if (result.hasData) {
            var movie = result.data;
            print("movie from listscreen");
            print(movie);
            return Material(
              type: MaterialType.transparency,
              child: Container(
                color: Colors.black12,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Hero(
                              tag: 'imageHero' + movie.id.toString(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
                                ),
                              ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Text(
                                  movie.originalTitle,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              movie.voteAverage.toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: Text(
                              'Description',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: StarWidget(),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Text(
                              movie.overview,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black87),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
