import 'dart:convert';

import 'package:newsapi/data/model/articleresults.dart';
import 'package:http/http.dart' as http;

import '../../commons/constants.dart';

abstract class NewsRemoteDataSource{
  Future<ArticleResults> searchNews(String date,String query);
}
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource{
  final http.Client client;
  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<ArticleResults> searchNews(String date, String query) async {
    final response = await http.get(Uri.parse("${BASE_URL}everything?q=${query}&sortBy=publishedAt&from=${date}&apiKey=${API_KEY}"));
    if (response.statusCode==200)
    {
      return ArticleResults.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load data from Newsapi');
    }
  }

}