import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapi/commons/failure.dart';
import 'package:newsapi/data/model/article.dart';
import 'package:newsapi/data/model/articleresults.dart';
import 'package:newsapi/data/model/source.dart';
import 'package:newsapi/domain/usecases/search_news.dart';
import 'package:newsapi/presentation/bloc/news_search/news_search_bloc.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchNews])
void main() {
  late MockSearchNews mockSearchNews;
  late NewsSearchBloc newsSearchBloc;
  setUp(() {
    mockSearchNews = MockSearchNews();
    newsSearchBloc = NewsSearchBloc(mockSearchNews);
  });
  final tArticle = <Article>[Article(source: Source(id: null, name:"Technews.tw"), author: "MoneyDJ",
      title:"Twitter 何時止損？馬斯克：2023 年「現金損益兩平」",
      description:"特斯拉（Tesla）執行長馬斯克（Elon Musk）買下知名社交媒體平台 Twitter 後，大賣特斯拉股票來填補 Twitter 錢坑，牽連特斯拉股價重挫。對此，馬斯克近日喊話，稱 Twitter 有望在 2023 年實現「現金損益兩平」（cash flow break-even），並為公司大幅...",
      url:"https://finance.technews.tw/2022/12/22/musk-twitter-cash-flow-break-even-2023/",
      urlToImage:"https://img.technews.tw/wp-content/uploads/2021/02/26151501/shutterstock_1777142483-e1625042589720.jpg",
      publishedAt:DateTime.parse("2022-12-22T01:45:20Z"),
      content:"TeslaElon Musk Twitter Twitter Twitter 2023 cash flow break-even\r\nGeorge Hotz 1221TwitterTwitter SpacesTwitterTwitter30\r\n1027Twitter50%TwitterTwitter90%\r\n21Twitter2,000\r\nTwitter 2021502Twitter202220%… [+129 chars]"
  )];
  final tArticleResults = ArticleResults(
      status: "ok", totalResults: 30, articles: tArticle);
  test('Should be a subclass of ArticleResults entity',() {
    final result = tArticleResults.toEntity();
    expect(result, tArticleResults);
  });
  test('Should be initial',() {
    expect(newsSearchBloc.state, NewsSearchInitial());
  });
  final tNewsModel = tArticleResults;
  final tQuery="tesla";
  blocTest('Should emit [Loading,Has Data] if successful', build: (){
    when(mockSearchNews.execute(tQuery)).thenAnswer((realInvocation)async=>Right(tNewsModel));
    return newsSearchBloc;
  },
    act:(NewsSearchBloc bloc)=>bloc.add(OnQueryNewsChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
    expect:()=>[NewsSearchLoading(),NewsSearchHasData(tNewsModel)],
    verify: (NewsSearchBloc bloc) {
      verify(mockSearchNews.execute(tQuery));
    }
  );
  blocTest('Should emit [Initial] when query is empty',
    build:()=>newsSearchBloc,
    act:(NewsSearchBloc bloc)=>bloc.add(OnQueryNewsChanged('')),
    wait: const Duration(milliseconds: 500),
    expect:()=>[NewsSearchInitial()],
  );
  blocTest('Should emit [Loading,Empty] if no data', build: (){
    when(mockSearchNews.execute(tQuery)).thenAnswer((realInvocation)async=>
        Right(ArticleResults(status:"",totalResults: 0, articles:[])));
    return newsSearchBloc;
  },
      act:(NewsSearchBloc bloc)=>bloc.add(OnQueryNewsChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
        expect:()=>[NewsSearchLoading(),NewsSearchEmpty('No News Found $tQuery')],
      verify: (NewsSearchBloc bloc) {
        verify(mockSearchNews.execute(tQuery));
      }
  );
  blocTest('Should emit [Loading,Error] when error', build: (){
    when(mockSearchNews.execute(tQuery)).thenAnswer((realInvocation)async=>
        Left(ServerFailure()));
    return newsSearchBloc;
  },
      act:(NewsSearchBloc bloc)=>bloc.add(OnQueryNewsChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect:()=>[NewsSearchLoading(),NewsSearchError('Server Failure',retry: () {})],
      verify: (NewsSearchBloc bloc) {
        verify(mockSearchNews.execute(tQuery));
      }
  );
}