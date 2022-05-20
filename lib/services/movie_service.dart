



import 'dart:async';

import 'package:dio/dio.dart';
import 'package:project_start/models/movie.dart';

class MovieService{


    static Future<List<Movie>> getMovieCategory({required int page , required String apiPath}) async{
       final dio = Dio();
       try{
         final response = await dio.get(apiPath, queryParameters: {
           'language': 'en-US',
           'api_key': '2a0f926961d00c667e191a21c14461f8',
           'page': page
         });

         final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
         return data;

       }on DioError catch (err){
         print(err);
           return [];
       }
     }

   static  Future<List<Movie>> searchMovies({required int page , required String apiPath, required String query}) async{
       final dio = Dio();
       try{
         final response = await dio.get(apiPath, queryParameters: {
           'language': 'en-US',
           'api_key': '2a0f926961d00c667e191a21c14461f8',
           'page': page,
           'query': query
         });
         final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
         return data;

       }on DioError catch (err){
         print(err);
         return [];
       }
     }






}