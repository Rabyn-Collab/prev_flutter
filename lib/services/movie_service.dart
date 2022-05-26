



import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:project_start/api.dart';
import 'package:project_start/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieService{


    static Future<List<Movie>> getMovieCategory({required int page , required String apiPath}) async{
      final prefs = await SharedPreferences.getInstance();
       final dio = Dio();
       try{
         final response = await dio.get(apiPath, queryParameters: {
           'language': 'en-US',
           'api_key': '2a0f926961d00c667e191a21c14461f8',
           'page': page
         });

         if(apiPath == Api.popularMovie){
           final response1 = await dio.get(apiPath, queryParameters: {
             'language': 'en-US',
             'api_key': '2a0f926961d00c667e191a21c14461f8',
             'page': 1
           });
           await prefs.setString('movie', jsonEncode(response1.data));
         }

         final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
         return data;

       }on DioError catch (err){
         if(apiPath  == Api.popularMovie){
           final  data = prefs.getString('movie');
           final extractData = jsonDecode(data!);
           final movieData = (extractData['results'] as List).map((e) => Movie.fromJson(e)).toList();
           print(movieData.length);
           return movieData;


         }
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
         if((response.data['results'] as List).isEmpty){
           final data = [Movie(
             id: 0,
               title: 'no-data',
               overview: '', poster_path: '', release_date: '', vote_average: '')];
           return data;
         }else{
           final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
           return data;
         }


       }on DioError catch (err){
         print(err);
         return [];
       }
     }






}