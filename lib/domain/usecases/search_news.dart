import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:newsapi/data/model/articleresults.dart';
import 'package:newsapi/domain/repositories/NewsRepository.dart';

import '../../commons/failure.dart';

class SearchNews {
  final NewsRepository repository;
  SearchNews(this.repository);
  Future<Either<Failure, ArticleResults>> execute(String query) {
    DateTime now = new DateTime.now();
    //DateTime date = new DateTime(now.day,now.month,now.day);
    return repository.searchNews(DateFormat('yyyy-MM-dd').format(now), query);
  }
}