import 'package:dio/dio.dart';
import 'package:flutter_news/models/news.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final newsProvider = StateNotifierProvider<NewsProvider, List<News>>((ref) => NewsProvider());


class NewsProvider extends StateNotifier<List<News>>{
  NewsProvider() : super([]){
     getData();
  }




  Future<void> getData() async{
    final dio = Dio();

    try{
      final response = await dio.get('https://free-news.p.rapidapi.com/v1/search', queryParameters: {
        'q': 'nasa',
        'lang': 'en'
      }, options: Options(
          headers: {
            'x-rapidapi-host': 'free-news.p.rapidapi.com',
            'x-rapidapi-key': '9cac60b351msh530cc0e2b8d88d2p1f9661jsn2c0049707e46'
          }
      ));

   List<News> newData = (response.data['articles'] as List).map((e) {
     return News.fromJson(e);
   }).toList();
    state = newData;


    }on DioError catch(e){
      print(e);
      throw e;
    }


  }



  Future<void> updateData(String query) async{
    final dio = Dio();

    try{
      state = [];
      final response = await dio.get('https://free-news.p.rapidapi.com/v1/search', queryParameters: {
        'q': query,
        'lang': 'en'
      }, options: Options(
          headers: {
            'x-rapidapi-host': 'free-news.p.rapidapi.com',
            'x-rapidapi-key': '9cac60b351msh530cc0e2b8d88d2p1f9661jsn2c0049707e46'
          }
      ));


      if(response.data['status'] == 'ok'){
        List<News> newData = (response.data['articles'] as List).map((e) {
          return News.fromJson(e);
        }).toList();
        state = newData;

      }else{
       state = [News(title: 'not found')];
      }

    }on DioError catch(e){
      print(e);
      throw e;
    }


  }







}