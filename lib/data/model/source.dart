class Source {
  Source({
    this.id,
    required this.name,
  });
/*
/*
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x)).where(
        (article)=> article.author!=null&&article.urlToImage!=null&&article.publishedAt!=null&&article.content!=null
    )),

* */

 */
  dynamic id;
  String name = "";
  factory Source.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null && json["name"] != null) {
      return Source(
        id: json["id"],
        name: json["name"],
      );
    }

    return Source(id: "", name: '');
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
