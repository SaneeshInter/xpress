import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/utils/utils.dart';
import '../model/user_add_availability.dart';
import '../model/user_availability_btw_date.dart';
import '../resources/respository.dart';
class UserAvailiability {
  final _repo = Repository();
  final _useravailability = PublishSubject<AddUserAvailabilityResponse>();
  final _useravailabilitydate = PublishSubject<List<AvailabilityList>>();

  Stream<AddUserAvailabilityResponse> get useravailabilitiy =>
      _useravailability.stream;

  Stream<List<AvailabilityList>> get useravailabilitiydate =>
      _useravailabilitydate.stream;

  addUserAvailability(String token, String date, String availability) async {
    print("TOKEN");
    print("DATE");
    print("AVAILABILITY");
    print(token);
    print(date);
    print(availability);
    AddUserAvailabilityResponse list =
        await _repo.addUserAvailability(token, date, availability);
    _useravailability.sink.add(list);
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  fetchuserAvailability(
      String token, DateTime startdate, DateTime endDate) async {
    UserAvailabilitydateResponse availabilityList =
        await _repo.UserAvailability(
            token, startdate.toString(), endDate.toString());
    List<AvailabilityList> availableMokeList = [];
    List<DateTime> datelist = getDaysInBetween(startdate, endDate);
    for (var dates in datelist) {
      AvailabilityList item = AvailabilityList();
      item.date = formatDate(dates);
      item.availability = 0;
      availableMokeList.add(item);
    }
    print("datelist.length");
    print(datelist.length);

    List<AvailabilityList>? listItem =
        availabilityList.response?.data!.availabilityList;
    var finalList = getDataList(availableMokeList, listItem);

    _useravailabilitydate.add(finalList);
  }

  dispose() {
    _useravailability.close();
    _useravailabilitydate.close();
  }

  List<AvailabilityList> getDataList(List<AvailabilityList> datelist,
      List<AvailabilityList>? availabilityList) {
    print("getDataList");
    if (null != availabilityList) {
      for (var avalilability in availabilityList) {
        var itemPosition = datelist
            .indexWhere((element) => compareValue(element, avalilability));

        print("itemPosition");
        print(itemPosition);
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
