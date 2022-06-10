class Visit{

  late String title;
  late String writer;
  late int heart;
  late String address;
  late List<String> tags;

  Visit.fromJson(Map<String, dynamic> aMap)
  {
    this.title = aMap["title"] ?? "";
    this.writer = aMap["writer"]?? "";
    this.heart = int.parse((aMap["heart"] ?? 1).toString());
    this.address = aMap["address"] ?? "";
    List<dynamic> dList = aMap["tags"] ?? [];
    this.tags = [];
    for(dynamic temp in dList)
      {
        tags.add(temp.toString());
      }

  }

  Visit({required String title, required String writer, required int heart, required String address,
  required List<String> tags})
  {
    this.title = title;
    this.writer = writer;
    this.heart = heart;
    this.address = address;
    this.tags = tags;
  }

  String toString()
  {
    return "$title $writer $heart $address $tags";
  }

  String tagsToString()
  {
    String temp = "";

    for(String tag in tags)
      {
        temp = temp + "#" + tag;
      }

    return temp;
  }
}