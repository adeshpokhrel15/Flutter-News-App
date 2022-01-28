import 'package:dio/dio.dart';
import 'package:flutter_ui/models/news.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newsProvider = FutureProvider((ref) => NewsProvider().getData());

class NewsProvider {
  Future<List<News>> getData() async {
    final dio = Dio();

    try {
      final response =
          await dio.get('https://free-news.p.rapidapi.com/v1/search',
              queryParameters: {'q': 'Elon Musk', 'lang': 'en'},
              options: Options(headers: {
                'x-rapidapi-host': 'free-news.p.rapidapi.com',
                'x-rapidapi-key':
                    '9cac60b351msh530cc0e2b8d88d2p1f9661jsn2c0049707e46'
              }));
      final news = (response.data['articles'] as List)
          .map((e) => News.fromJSon(e))
          .toList();
      print(news);
      return news;
    } on DioError catch (e) {
      print(e);
      throw e;
    }
  }
}
