import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:newsapi/commons/failure.dart';
import 'package:newsapi/data/model/articleresults.dart';
import 'package:newsapi/domain/repositories/NewsRepository.dart';

import '../../commons/exception.dart';
import '../datasources/news_remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ArticleResults>> searchNews(
      String date, String query) async {
    try {
      final result = await remoteDataSource.searchNews(date, query);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }
}
