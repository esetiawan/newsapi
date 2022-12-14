import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapi/presentation/bloc/news_search/news_search_bloc.dart';
import '../../data/model/article.dart';
import 'package:provider/provider.dart';
import '../../provider/newsprovider.dart';
import 'detail_news.dart';
class NewsSearchListPage extends StatelessWidget {
  const NewsSearchListPage({Key? key}):super(key:key);
  Widget _buildList() {
    return BlocBuilder<NewsSearchBloc,NewsSearchState>(
        builder: (context,state) {
          if(state is NewsSearchLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is NewsSearchHasData) {
            final result = state.data;
            return Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: result.articles.length,
                  itemBuilder: (context,index) {
                    return _buildArticleItem(context, result.articles[index]);
                  }),
            );
          }
          else if (state is NewsSearchError ) {
            return Center(
                child: state.retry==null?Material(
                  child: Text(state.message),
                ):Material(
                  child: Text(state.message+",retry:"+state.retry.toString()),
                )
            );
          }
          else if (state is NewsSearchEmpty) {
            return Center(
                child: Text(state.message),
            );
          }
          else {
            return Center(
                child: Material(
                  child: Text(''),
                )
            );
          }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: 300,
          height: 300,
          child: _buildList()
      ),
    );
  }
}

Widget _buildArticleItem(BuildContext context, Article article) {
  return Material(
      child:ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: Image.network(article.urlToImage, width:100),
          title: Text(article.title),
          subtitle: Text(article.author),
          onTap:() {
            Navigator.pushNamed(context,DetailNewsScreen.routeName,arguments:article);
          }
      )
  );
}
