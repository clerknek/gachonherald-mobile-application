import 'package:flutter_gms/data/article_data.dart';

class ArticleInfo {
  String function;
  String title;
  String subTitle;
  String reporter;
  String email;
  String date;
  String time;
  String article;
  String image;
  ArticleInfo(this.function, this.title, this.subTitle, this.reporter, this.email, this.date, this.time, this.article, this.image);
}

List rPageInfo() {
  var e = [];
  for (int i = 0; i < titleList.length; i++) {
    var rv = titleList.length - i - 1;
    e.add(ArticleInfo(functionList[rv], titleList[rv], subTitleList[rv], reporterList[rv], emailList[rv], dateList[rv], timeList[rv], articleList[rv], imageList[rv]));
  }
  return e;
}
