import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapi/presentation/bloc/news_search/news_search_bloc.dart';
import 'package:newsapi/presentation/pages/more_news.dart';
import 'package:newsapi/presentation/pages/news_search_screen.dart';
import 'package:provider/provider.dart';

import '../commons/styles.dart';
import '../data/model/article.dart';
import 'injection.dart' as di;
import 'presentation/pages/detail_news.dart';
import 'presentation/pages/news_screen.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [BlocProvider(create: (_) => di.locator<NewsSearchBloc>())],
      child: MaterialApp(
          title: 'News App',
          theme: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: primaryColor,
                    onPrimary: Colors.black,
                    secondary: secondaryColor,
                  ),
              scaffoldBackgroundColor: Colors.white,
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: myTextTheme,
              appBarTheme: const AppBarTheme(elevation: 0),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      primary: secondaryColor,
                      onPrimary: Colors.white,
                      textStyle: const TextStyle(),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(0)))))),
          initialRoute: NewsScreenSearch.routeName,
          routes: {
            NewsScreen.routeName: (context) => const NewsScreen(),
            NewsScreenSearch.routeName: (context) => const NewsScreenSearch(),
            DetailNewsScreen.routeName: (context) => DetailNewsScreen(
                article: ModalRoute.of(context)?.settings.arguments as Article),
            MoreNewsScreen.routeName: (context) => MoreNewsScreen(
                url: ModalRoute.of(context)?.settings.arguments as String),
          }),
    );
  }
}
