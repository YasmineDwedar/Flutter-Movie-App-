import 'package:flutterlab3/API/MovieAPI.dart';
import 'package:flutterlab3/Models/DetailsPojo.dart';
import 'package:flutterlab3/Models/MoviesPojo.dart';
import 'package:flutterlab3/Models/genre.dart';

class MovieRepisatory {
  Future<List<MoviesPojo>> getMovies() async {
    return await MovieAPI().fetchMovies();
  }

  Future<List<Genre>> getGenres() async {
    return await MovieAPI().getMovieGenere();
  }

  Future<DetailsPojo> getMovieDetails(int id) async {
    return await MovieAPI().getMovieDetails(id);
  }
}
