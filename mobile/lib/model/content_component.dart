class ContentComponent
{
  static const TEXT = "text";
  static const IMAGE = "image";
  static const SPACER = "spacer";
  static const TYPE = "type";
  static const CONTENT = "content";


  late final String type;

  ContentComponent(this.type);

  ContentComponent.fromJson(Map<String, dynamic> aMap)
  {
    this.type = aMap[TYPE] ?? SPACER;
  }

  bool isText()
  {
    return type == TEXT;
  }

  bool isSpacer()
  {
    return type == SPACER;
  }

  bool isImage()
  {
    return type == IMAGE;
  }

  Map<String, String> toJson()
  {
    return {
      ContentComponent.TYPE: type
    };
  }
}

class TextContent extends ContentComponent{

  late String _text;

  TextContent({ required String text}) : super(ContentComponent.TEXT){
    _text = text;
  }

  TextContent.fromJson(Map<String, dynamic> aMap) : super(ContentComponent.TEXT)
  {
    this._text = aMap[ContentComponent.CONTENT] ?? "";
  }

  @override
  Map<String, String> toJson()
  {
    return {
      ContentComponent.TYPE: type,
      ContentComponent.CONTENT : _text
    };
  }

  String getText()
  {
    return _text;
  }

  void setText(String text)
  {
    _text = text;
  }
}

class SpacerContent extends ContentComponent{

  SpacerContent() : super(ContentComponent.SPACER);

  SpacerContent.fromJson(Map<String, dynamic> aMap) : super(ContentComponent.SPACER);


  @override
  Map<String, String> toJson()
  {
    return {
      ContentComponent.TYPE: type
    };
  }

}

class ImageContent extends ContentComponent{
  late String _imagePath;

  ImageContent({ String path = ""}) : super(ContentComponent.IMAGE){
    _imagePath = path;
  }

  ImageContent.fromJson(Map<String, dynamic> aMap) : super(ContentComponent.IMAGE)
  {
    this._imagePath = aMap[ContentComponent.CONTENT] ?? "";
  }

  @override
  Map<String, String> toJson()
  {
    return {
      ContentComponent.TYPE: type,
      ContentComponent.CONTENT : _imagePath
    };
  }

  String getPath()
  {
    return _imagePath;
  }

  void setPath(String path)
  {
    _imagePath = path;
  }

  bool isValidPath()
  {
    return !(_imagePath.length == 0);
  }
}
