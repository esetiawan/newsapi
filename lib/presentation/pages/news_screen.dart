import 'package:flutter/material.dart';
import '../../data/model/article.dart';
import '../../data/api/apiservice.dart';
import '../../provider/newsprovider.dart';
import 'package:provider/provider.dart';
import 'newslistpage.dart';

class NewsScreen extends StatefulWidget {
  static const routeName='/article_list';
  const NewsScreen({Key? key}):super(key:key);
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        ChangeNotifierProvider<NewsProvider>(
          create: (_)=>NewsProvider(apiService: ApiService(),country:'id',
              category:'business'),
          child: const NewsListPage(),
        )
    );
  }
}
