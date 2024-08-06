class News {
  String? status;
  int? totalResults;
  List<Results>? results;

  News({this.status, this.totalResults, this.results});

  News.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalResults'] = totalResults;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? articleId;
  String? title;
  String? link;
  String? description;
  String? pubDate;
  String? imageUrl;
  String? sourceName;
  List<String>? category;

  Results({
    this.articleId,
    this.title,
    this.link,
    this.description,
    this.pubDate,
    this.imageUrl,
    this.sourceName,
    this.category,
  });

  Results.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    title = json['title'];
    link = json['link'];
    description = json['description'];
    pubDate = json['pubDate'];
    imageUrl = json['image_url'];
    sourceName = json['source_name'];
    category = json['category'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['article_id'] = articleId;
    data['title'] = title;
    data['link'] = link;
    data['description'] = description;
    data['pubDate'] = pubDate;
    data['image_url'] = imageUrl;
    data['source_name'] = sourceName;
    data['category'] = category;
    return data;
  }
}
