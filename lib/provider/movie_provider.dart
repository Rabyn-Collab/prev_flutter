import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_start/models/movie_state.dart';
import 'package:project_start/services/movie_service.dart';



final movieProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(MovieState.initState()));

class MovieProvider extends StateNotifier<MovieState>{
  MovieProvider(super.state){
       getData();
  }


    Future<void> getData() async{
         final response = await MovieService.getMovieCategory(page:  state.page, apiPath: state.apiPath);
         state = state.copyWith(
           movies:  response
         );

    }






}