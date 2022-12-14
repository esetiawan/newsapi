import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapi/data/model/articleresults.dart';

import '../../commons/constants.dart';

abstract class NewsRemoteDataSource {
  Future<ArticleResults> searchNews(String date, String query);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client = http.Client();
  NewsRemoteDataSourceImpl();

  @override
  Future<ArticleResults> searchNews(String date, String query) async {
    final response = await http.get(Uri.parse(
        "${BASE_URL}everything?q=${query}&sortBy=publishedAt&from=${date}&apiKey=${API_KEY}"));
    if (response.statusCode == 200) {
      return ArticleResults.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data from Newsapi');
    }
  }
}
