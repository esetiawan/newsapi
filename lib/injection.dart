import 'package:get_it/get_it.dart';
import 'package:newsapi/data/datasources/news_remote_data_source.dart';
import 'package:newsapi/data/repositories/NewsRepositoryImpl.dart';
import 'package:newsapi/domain/repositories/NewsRepository.dart';
import 'package:newsapi/domain/usecases/search_news.dart';
import 'package:newsapi/presentation/bloc/news_search/news_search_bloc.dart';

final locator = GetIt.instance;
void init() {
  locator.registerFactory(() => NewsSearchBloc(locator()));
  locator.registerLazySingleton(() => SearchNews(locator()));
  locator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(remoteDataSource:locator()));
  locator.registerLazySingleton<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(client: locator()));
}