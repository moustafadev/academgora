
class News {
  String? id;
  String? photo;

  News({this.id,this.photo});

  static News fromJson(map) {
    News news = News();
    news.id = map['Место']??"";
    news.photo = map["Фото"] ?? "";
    return news;
  }

  static Map<String, dynamic> toJson(String id, String photo){
    return {
      'Место':id,
      'Фото':photo
    };
  }

  // static Map<dynamic, dynamic> _parseDates(

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is News &&
          runtimeType == other.runtimeType &&
          photo == other.photo;

  @override
  int get hashCode => photo.hashCode;
}
