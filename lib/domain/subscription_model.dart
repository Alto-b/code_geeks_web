// ignore_for_file: non_constant_identifier_names

class SubscriptionModel{
  String subsId;
  String title;
  String language;
  String description;
  String photo;
  String amount;
  String LangImg;
  String LangDesc;
  List videos;

  SubscriptionModel({
    required this.subsId,
    required this.title,
    required this.language,
    required this.description,
    required this.photo,
    required this.amount,
    required this.LangImg,
    required this.LangDesc,
    required this.videos
  });
}