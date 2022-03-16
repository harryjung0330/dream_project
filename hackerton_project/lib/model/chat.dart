class Chat
{
  final int chatId;
  final int studyRoomId;
  final String content;
  String? profilePicturePath;
  final int speakerId;
  final DateTime? chatDate;

  Chat({required this.chatId, required this.studyRoomId, required this.content, required this.profilePicturePath,
  required this.speakerId, required this.chatDate});

  Chat.fromJson(Map<String, dynamic> chatJson):
        chatId = chatJson["chatId"] == null ? -1 :int.tryParse(chatJson["chatId"] as String)?? -1,
        studyRoomId = chatJson["studyRoomId"] == null ? -1 : int.tryParse(chatJson["studyRoomId"] as String) ?? -1,
        content = chatJson["content"] ?? "",
        speakerId = chatJson["speakerId"] == null ? -1 :int.tryParse(chatJson["speakerId"] as String)?? -1,
        chatDate = chatJson["chatDate"] == null ? null: DateTime.tryParse(chatJson["chatDate"])
  {
    profilePicturePath = chatJson["profilePicturePath"];
  }

  Map<String, dynamic> toJson()
  {
    return {
      "chatId": chatId,
      "studyRoomId": studyRoomId,
      "content": content,
      "profilePicturePath": profilePicturePath,
      "speakerId": speakerId,
      "chatDate" : chatDate.toString()
    };
  }

  bool isNull()
  {
    return (chatId == -1 || studyRoomId == -1 || chatDate == null);
  }

}