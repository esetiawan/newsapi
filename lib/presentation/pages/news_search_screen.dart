import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/news_search/news_search_bloc.dart';
import 'newssearchlistpage.dart';

class NewsScreenSearch extends StatefulWidget {
  static const routeName = '/article_search_list';
  const NewsScreenSearch({Key? key}) : super(key: key);
  @override
  State<NewsScreenSearch> createState() => _NewsScreenSearchState();
}

class _NewsScreenSearchState extends State<NewsScreenSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Article"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (query) {
                  context.read<NewsSearchBloc>().add(OnQueryNewsChanged(query));
                },
                decoration: InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              SizedBox(height: 16),
              Text('Search Result'),
              Container(
                height: 300,
                child: NewsSearchListPage(),
              ),
            ],
          ),
        ));
  }
}
