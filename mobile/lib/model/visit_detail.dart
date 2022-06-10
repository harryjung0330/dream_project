import 'package:flutter/material.dart';
import 'package:hackerton_project/model/content_component.dart';
import 'package:http/http.dart';

import 'export_file.dart';


class VisitDetail extends Visit{
  late String detailAddress;
  late int readView;
  late String nickname;
  late Content content;

  VisitDetail.fromJson(Map<String, dynamic> aMap) :super.fromJson(aMap)
  {
    this.detailAddress = aMap["detailAddress"] ?? "";
    this.readView = int.tryParse((aMap["readView"] ?? 0).toString()) ?? 0;
    this.nickname = aMap["nickname"] ?? "";
    this.content = Content.fromJson(aMap);


  }

  VisitDetail({required String title, required String writer, required int heart, required String address,
    required List<String> tags, required this.detailAddress, required this.readView, required this.nickname, required this.content}): super(title: title, writer: writer, heart: heart, address: address, tags:tags);


  Map<String, dynamic> toJson()
  {
    return {
      "title" : title,
      "writer": writer,
      "heart": heart,
      "address": address,
      "content": content.toJson(),
      "tags": tags,
      "readView": readView,
      "detailAddress": detailAddress
    };
  }

}

class Content{
  late List<ContentComponent> _contentList;

  Content()
  {
    this._contentList = [];
  }


  Content.fromJson(Map<String, dynamic> aMap)
  {
    this._contentList = [];
    List<dynamic> temp = aMap["content"] ?? [];

    for(dynamic te in temp)
      {
        Map<String, dynamic> t = te as Map<String, dynamic>;

        if(t[ContentComponent.TYPE] == ContentComponent.TEXT)
          {
            _contentList.add(TextContent(text:t[ContentComponent.CONTENT]?? ""));
          }
        else if(t[ContentComponent.TYPE] == ContentComponent.SPACER)
          {
            _contentList.add(SpacerContent());
          }
        else if(t[ContentComponent.TYPE] == ContentComponent.IMAGE)
          {
            _contentList.add(ImageContent(path:t[ContentComponent.CONTENT] ?? ""));
          }
      }
  }

  List<Map<String, dynamic>> toJson()
  {
    List<Map<String, dynamic>> temp = [];

    for(ContentComponent comp in _contentList)
    {
      temp.add(comp.toJson());
    }

    return temp;
  }

  void addText(TextContent textContent)
  {
    this._contentList.add(textContent);
  }

  void addSpacer(SpacerContent spacerContent)
  {
    this._contentList.add(spacerContent);
  }

  void addImage(ImageContent imageContent)
  {
    this._contentList.add(imageContent);
  }

  void removeText(TextContent cont)
  {
    this._contentList.remove(cont);
  }

  void removeSpacer(SpacerContent cont)
  {
    this._contentList.remove(cont);
  }

  void removeImage(ImageContent cont)
  {
    this._contentList.remove(cont);
  }

  List<ContentComponent> getContents()
  {
    return [..._contentList];
  }

  
}

