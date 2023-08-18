class NewsQueryModel{
  late String newsHead;
  late String newsDas;
  late String newsImg;
  late String newsUrl;

  NewsQueryModel({this.newsHead='News HeadLine',this.newsDas='some News',this.newsUrl='Some Url',this.newsImg='Some img'});
  factory NewsQueryModel.fromMap(Map news){
    return NewsQueryModel(
      newsHead: news['title'],
      newsDas: news['description'],
      newsImg: news['urlToImage'],
      newsUrl: news['url']

    );
  }
}