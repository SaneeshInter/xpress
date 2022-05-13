import 'package:rxdart/rxdart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xpresshealthdev/resources/respository.dart';

import '../model/manager_shift_calendar_respo.dart';

class ManagerShiftCalendarBloc {
  final _repo = Repository();
  final _getshiftcalendar = PublishSubject<ManagerGetScheduleByYear>();
  final _filterItems = PublishSubject<List<Items>>();
  List<Item>? itemlListALl = [];
  List<Items>? eventListByDate = [];

  Stream<ManagerGetScheduleByYear> get managercalendar =>
      _getshiftcalendar.stream;

  Stream<List<Items>> get filtered => _filterItems.stream;

  managerGetScheduleByYear(String token, String year) async {
    ManagerGetScheduleByYear respo =
        await _repo.fetchmanagerscheduleyear(token, year);
    itemlListALl = respo.response?.data?.item;
    _getshiftcalendar.sink.add(respo);
  }

  dispose() {
    _getshiftcalendar.close();
  }


  filterItemByDates(DateTime selectedDay) {
    var itemList = itemlListALl!.where((element) {
      DateTime itemDay = DateTime.parse(element.date.toString());
      return isSameDay(itemDay, selectedDay);
    });
    if (itemList.isNotEmpty) {
      _filterItems.sink.add(itemList.first.items ?? []);
    } else {
      _filterItems.sink.add([]);
    }
  }
}

final managercalendarBloc = ManagerShiftCalendarBloc();
