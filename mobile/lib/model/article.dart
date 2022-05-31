class Article{
  static const PICT_URL = "pictUrl";
  static const PATH = "path";
  static const TITLE = "title";
  static const FETCH_TIME = "fetchTime";

  late String pictUrl;
  late String path;
  late String title;
  late int fetchTime;

  Article.fromJson(Map<String, dynamic> aJson)
  {
    this.pictUrl = aJson[PICT_URL] ??"";
    this.path = aJson[PATH] ?? "";
    this.title = aJson[TITLE] ?? "";
    String temp = (aJson[FETCH_TIME]?? -1).toString();
    this.fetchTime = int.parse(temp) ??-1;
  }

  Map<String, dynamic> toJson()
  {
    return {
      PICT_URL: this.pictUrl,
      PATH : path,
      TITLE : title,
      FETCH_TIME : fetchTime
    };
  }
}