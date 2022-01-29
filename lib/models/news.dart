



class News{

  late String? title;
  late String? author;
  late String? publishedDate;
  late String? link;
  late String? summary;
  late String? media;


  News({
    this.summary,
    this.publishedDate,
    this.media,
     this.link,
    this.author,
   this.title,
});


  factory News.fromJson(Map<String, dynamic> json){
  return News(
      summary: json['summary'] ?? '',
      publishedDate: json['published_date'] ?? '',
      media: json['media'] ?? 'https://asvs.in/wp-content/uploads/2017/08/dummy.png',
      link: json['link'] ?? '' ,
      author: json['author'] ?? '' ,
      title: json['title'] ?? ''
  );
  }



}