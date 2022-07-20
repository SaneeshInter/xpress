class NotificationModel {
  String date;
  List<NotificationItemModel> list;

  NotificationModel({required this.date, required this.list});
}

class NotificationItemModel{
  String title;
  String image;
  String subtitle;
  String date;
  String shiftid;

  NotificationItemModel({required this.title, required this.image, required this.subtitle, required this.date,required this.shiftid});
}