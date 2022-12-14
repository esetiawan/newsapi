import 'package:flutter/material.dart';
import '../../data/model/article.dart';
import '../../data/api/apiservice.dart';
import '../../provider/newsprovider.dart';
import 'package:provider/provider.dart';
import 'newslistpage.dart';

class NewsScreenSearch extends StatefulWidget {
  static const routeName='/article_search_list';
  const NewsScreenSearch({Key? key}):super(key:key);
  @override
  State<NewsScreenSearch> createState() => _NewsScreenSearchState();
}

class _NewsScreenSearchState extends State<NewsScreenSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const NewsSearchListPage());
  }
}
