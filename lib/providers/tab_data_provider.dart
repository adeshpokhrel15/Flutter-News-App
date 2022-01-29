
import 'package:dio/dio.dart';
import 'package:flutter_news/models/news.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final tabNewsProvider = StateNotifierProvider.family<TabNewsProvider, List<News>, String>((ref, query) => TabNewsProvider(query: query));


class TabNewsProvider extends StateNotifier<List<News>> {
  TabNewsProvider({required this.query}) : super([]) {
    getData();
  }

  final String query;

  Future<void> getData() async {
    final dio = Dio();

    try {

      await Future.delayed(Duration(seconds: 3));

      final response = await dio.get(
          'https://free-news.p.rapidapi.com/v1/search', queryParameters: {
        'q': query,
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
    } on DioError catch (e) {
      print(e);
      throw e;
    }
  }

}