import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_start/api.dart';
import 'package:project_start/models/movie.dart';
import 'package:project_start/models/movie_state.dart';
import 'package:project_start/services/movie_service.dart';



final movieProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider());

class MovieProvider extends StateNotifier<MovieState>{
  MovieProvider() : super(MovieState.initState()){
       getData();
  }


    Future<void> getData() async{
     List<Movie> _movies = [];
    if(state.searchText.isEmpty){
          _movies = await MovieService.getMovieCategory(page: state.page, apiPath: state.apiPath);
    }else{
      _movies = await MovieService.searchMovies(page: state.page, apiPath: state.apiPath, query: state.searchText);
    }

     state = state.copyWith(
       movies:  [...state.movies, ..._movies]
     );

    }

    void updateCategory(String apiPath){
      state =  state.copyWith(
        movies: [],
        searchText: '',
        apiPath: apiPath
      );
      getData();
    }

  void searchMovie(String searchText){
    state =  state.copyWith(
        movies: [],
        searchText: searchText,
      apiPath: Api.searchMovie
    );
    getData();
  }

  void loadMore(){
    state =  state.copyWith(
        searchText: '',
      page: state.page + 1
    );
    getData();
  }


}

final videoProvider = FutureProvider.family((ref, int id) => VideoProvider().getVideoKey(id));

class VideoProvider {

  Future<String> getVideoKey(int id) async{
    final dio = Dio();
    final response = await dio.get('https://api.themoviedb.org/3/movie/$id/videos', queryParameters: {
      'api_key': '2a0f926961d00c667e191a21c14461f8'
    });
     return response.data['results'][0]['key'];
  }

}