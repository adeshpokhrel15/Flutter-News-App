class News {
  late String? title;
  late String? author;
  late String? publishedData;
  late String? link;
  late String? cleanUrl;
  late String? summary;
  late String? media;

  News({
    this.publishedData,
    this.author,
    this.link,
    this.summary,
    this.cleanUrl,
    this.media,
    this.title,
  });

  factory News.fromJSon(Map<String, dynamic> json) {
    return News(
        title: json['title'],
        author: json['author'],
        cleanUrl: json['clearnUrl'],
        link: json['link'],
        media: json['media'],
        publishedData: json['publishedData'],
        summary: json['summary']);
  }
}
