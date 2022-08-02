import 'user_view_request_response.dart';

// class FilterBookingList {
//   List<Items> requested = [];
//   List<Items> confirmed = [];
//   List<Items> reject = [];
//   List<Items> completed = [];
//   List<Items> history = [];
// }
class FilterBookingList {
  List<DateItems> requested =[];
   List<DateItems> confirmed  =[];
   List<DateItems> reject =[];
   List<DateItems> completed  =[];
   List<DateItems> history =[];
   List<DateItems> upcoming =[];
}
class DateItems{
  String date;
  List<Items> list;

  DateItems(this.date, this.list);
}