// Reposible form taking response body and parsing it into Json
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutterlab3/HttpClient/HttpClient.dart';
import 'package:flutterlab3/Models/DetailsPojo.dart';
import 'package:flutterlab3/Models/MoviesPojo.dart';
import 'package:flutterlab3/Models/genre.dart';

class MovieAPI {
  Future<List<MoviesPojo>> fetchMovies() async {
    // HttpClient client = new HttpClient();
    //  var jsonResponse = await client.get();
    String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=6557d01ac95a807a036e5e9e325bb3f0&sort_by=popularity.desc';
    var jsonResponse = await HttpClient().get(url);
//    print("look here");
//    print(jsonResponse['results']);
    //Take every item and return a json obj ml pojo bt3y for each entry
    return List<MoviesPojo>.from(
        jsonResponse['results'].map((i) => MoviesPojo.fromJson(i)));
  }

  Future<List<Genre>> getMovieGenere() async {
    var jsonResponse = await HttpClient().get(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=6557d01ac95a807a036e5e9e325bb3f0&language=en-US");
    var results = jsonResponse['genres'];
    return List<Genre>.from(
        results.map((jsonEntry) => Genre.fromJson(jsonEntry)));
  }

  Future<DetailsPojo> getMovieDetails(int id) async {
    var jsonResponse = await HttpClient().get(
        'https://api.themoviedb.org/3/movie/$id?api_key=6557d01ac95a807a036e5e9e325bb3f0&language=en-US');
    print("look here");
    print(jsonResponse);
    return DetailsPojo.fromJson(jsonResponse);
  }
}
