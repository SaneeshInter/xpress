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
  Availability? availability = null;
  double? pageOffset = 0;

  final _repo = Repository();

  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;

  final _useravailability = PublishSubject<AddUserAvailabilityResponse>();
  final _useravailabilitydate = PublishSubject<List<AvailabilityList>>();

  Stream<AddUserAvailabilityResponse> get useravailabilitiy =>
      _useravailability.stream;

  Stream<List<AvailabilityList>> get useravailabilitiydate =>
      _useravailabilitydate.stream;

  addUserAvailability(String date, String availability) async {
    _visibility.add(true);
    AddUserAvailabilityResponse list =
        await _repo.addUserAvailability(token!, date, availability);
    _useravailability.sink.add(list);
    _visibility.add(false);
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  fetchuserAvailability() async {
    _visibility.add(true);
    UserAvailabilitydateResponse availabilityList =
        await _repo.UserAvailability(
            token!, startDate.toString(), endDate.toString());
    List<AvailabilityList> availableMokeList = [];
    List<DateTime> datelist = getDaysInBetween(startDate, endDate);
    for (var dates in datelist) {
      AvailabilityList item = AvailabilityList();
      item.date = formatDate(dates);
      item.availability = "0";
      availableMokeList.add(item);
    }
    List<AvailabilityList>? listItem =
        availabilityList.response?.data!.availabilityList;
    var finalList = getDataList(availableMokeList, listItem);

    _useravailabilitydate.add(finalList);
    _visibility.add(false);
  }

  dispose() {
    _useravailability.close();
    _useravailabilitydate.close();
  }

  List<AvailabilityList> getDataList(List<AvailabilityList> datelist,
      List<AvailabilityList>? availabilityList) {
    if (null != availabilityList) {
      for (var avalilability in availabilityList) {
        var itemPosition = datelist
            .indexWhere((element) => compareValue(element, avalilability));
        if (itemPosition != -1)
          datelist[itemPosition].availability = avalilability.availability;
      }
    }
    return datelist;
  }

  bool compareValue(AvailabilityList element, AvailabilityList avalilability) {
    print(element.date);
    print(avalilability.date);

    return element.date == avalilability.date;
  }
}

final availabilitybloc = UserAvailiability();
