import 'package:dartz/dartz.dart';
import 'package:newsapi/commons/failure.dart';
import 'package:newsapi/data/model/articleresults.dart';

abstract class NewsRepository{
  Future<Either<Failure,ArticleResults>> searchNews(String date, String query);
}