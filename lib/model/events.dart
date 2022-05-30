import '../model/user_complted_shift.dart';

class Events {
  final DateTime? dateTime;
 final List<Items>? items;
  Events({required this.dateTime, required this.items});
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = this.dateTime;
    data['location'] = this.items;
    return data;
  }
}