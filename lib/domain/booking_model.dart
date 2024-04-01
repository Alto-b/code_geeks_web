// ignore_for_file: non_constant_identifier_names

class BookingModel{
  String sub_id;
  String sub_title;
  String sub_lang;
  String sub_photo;
  String booking_amount;
  String booking_id;
  String date;
  String expiry;
  String guide_id;
  String guide_name;
  String guide_photo;
  String status;
  String user_id;
  Map<String,dynamic> subscriptionDetails;

  BookingModel({
    required this.sub_id,
    required this.sub_title,
    required this.sub_lang,
    required this.sub_photo,
    required this.booking_amount,
    required this.booking_id,
    required this.date,
    required this.expiry,
    required this.guide_id,
    required this.guide_name,
    required this.guide_photo,
    required this.status,
    required this.user_id,
    required this.subscriptionDetails
  });
}