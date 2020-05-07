import 'package:flutterlab3/Models/DetailsPojo.dart';
import 'package:flutterlab3/Models/MoviesPojo.dart';
import 'package:flutterlab3/Models/genre.dart';
import 'package:flutterlab3/repository/MovieRepository.dart';

class MovieBloc {
  Future<List<MoviesPojo>> singleMovieDisplay() async {
    List<MoviesPojo> allMovies = await MovieRepisatory().getMovies();
    return allMovies;
  }

  Future<List<Genre>> getGenresFromRepo() async {
    return await MovieRepisatory().getGenres();
  }

  Future<DetailsPojo> getMovieDetailsFromRepo(int id) async {
    return await MovieRepisatory().getMovieDetails(id);
  }
}
