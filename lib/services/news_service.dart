import 'package:dio/dio.dart';
import 'package:project_start/api.dart';



class NewsService{



 static  Future  getNews() async{
    final dio = Dio();
    try{
      final response = await dio.get(Api.searchNewsApi,
      queryParameters: {
        'q': 'nasa',
        'lang':'en'
      },
        options: Options(
          headers: {
            'X-RapidAPI-Host': 'free-news.p.rapidapi.com',
            'X-RapidAPI-Key': '89e53c72d7msh16aa8c041814a4cp1f3e79jsn333d7bcaf747'
          }
        )

      );
      print(response.data);

    }on DioError catch (err){


    }



  }



}