import 'package:rxdart/rxdart.dart';
import '../utils/utils.dart';

import '../main.dart';
import '../model/user_add_availability.dart';
import '../model/user_availability_btw_date.dart';
import '../resources/respository.dart';

class UserAvailiability {
  String? token;
  var itemSelected = 0;
  var daysCount = 500;
  var startDate;
  var endDate;
  bool visibility = false;
  double viewportFraction = 0.8;
  Availability? availability;
  double? pageOffset = 0;

  final _repo = Repository();

  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;

  final _userAvailability = PublishSubject<AddUserAvailabilityResponse>();
  final _userAvailabilityDate = PublishSubject<List<AvailabilityList>>();

  Stream<AddUserAvailabilityResponse> get userAvailability =>
      _userAvailability.stream;

  Stream<List<AvailabilityList>> get userAvailabilityDate =>
      _userAvailabilityDate.stream;

  addUserAvailability(String date, String availability) async {
    _visibility.add(true);
    AddUserAvailabilityResponse list =
        await _repo.addUserAvailability(token!, date, availability);
    _userAvailability.sink.add(list);
    _visibility.add(false);
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  fetchUserAvailability() async {
    _visibility.add(true);
    UserAvailabilitydateResponse availabilityList =
        await _repo.UserAvailability(
            token!, startDate.toString(), endDate.toString());
    List<AvailabilityList> availableMakeList = [];
    List<DateTime> dateList = getDaysInBetween(startDate, endDate);
    for (var dates in dateList) {
      AvailabilityList item = AvailabilityList();
      item.date = formatDate(dates);
      item.availability = "0";
      availableMakeList.add(item);
    }
    List<AvailabilityList>? listItem =
        availabilityList.response?.data!.availabilityList;
    var finalList = getDataList(availableMakeList, listItem);

    _userAvailabilityDate.add(finalList);
    _visibility.add(false);
  }

  dispose() {
    _userAvailability.close();
    _userAvailabilityDate.close();
  }

  List<AvailabilityList> getDataList(List<AvailabilityList> datelist,
      List<AvailabilityList>? availabilityList) {
    if (null != availabilityList) {
      for (var availability in availabilityList) {
        var itemPosition = datelist
            .indexWhere((element) => compareValue(element, availability));
        if (itemPosition != -1) {
          datelist[itemPosition].availability = availability.availability;
        }
      }
    }
    return datelist;
  }

  bool compareValue(AvailabilityList element, AvailabilityList avalilability) {

    return element.date == avalilability.date;
  }
}

final availabilityBloc = UserAvailiability();
