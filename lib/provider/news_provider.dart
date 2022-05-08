import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_start/models/news.dart';
import 'package:project_start/services/news_service.dart';



final newsProvider = StateNotifierProvider.family<GetQueryNews, List<News>, String>((ref, String query) => GetQueryNews(query: query));

class GetQueryNews extends StateNotifier<List<News>>{

  GetQueryNews({required this.query}) : super([]){
    getQuery();
  }




  final String query;

  Future<void> getQuery() async {
    final response = await NewsService.getQueryNews(query);
    state = response;
  }


}

