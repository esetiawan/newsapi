
import 'package:equatable/equatable.dart';
import 'package:newsapi/data/model/source.dart';

class Article extends Equatable {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: Source.fromJson(json["source"]),
    author: json["author"] == null ? "" : json["author"],
    title: json["title"],
    description: json["description"]== null ? "" : json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"]== null ? "https://bitsofco.de/content/images/2018/12/broken-1.png" : json["urlToImage"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"] == null ? "" : json["content"],
  );

  Map<String, dynamic> toJson() => {
    "source": source.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt.toIso8601String(),
    "content": content == null ? "" : content,
  };

  @override
  List<Object?> get props => [source,author,title,
    description,url,urlToImage,publishedAt,content];
}