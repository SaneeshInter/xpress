import 'package:rxdart/rxdart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xpresshealthdev/resources/respository.dart';

import '../model/user_shift_calender.dart';
import '../model/utility_respo.dart';

class ShiftCalendarBloc {
  final _repo = Repository();
  final _shiftcalender = PublishSubject<UserGetScheduleByYear>();
  final _filterItem = PublishSubject<List<Items>>();
  List<Item>? itemlListALl = [];
  List<Items>? eventListByDate = [];

  Stream<UserGetScheduleByYear> get shiftcalendar => _shiftcalender.stream;

  Stream<List<Items>> get filteredBydate => _filterItem.stream;

  userGetScheduleByYear(String token, String year) async {
    UserGetScheduleByYear respo =
        await _repo.fetchuserscheduleyear(token, year);
    itemlListALl = respo.response?.data?.item;
    _shiftcalender.sink.add(respo);
  }

  dispose() {
    _shiftcalender.close();
  }

  filterItemByDate(DateTime selectedDay) {
    var itemList = itemlListALl!.where((element) {
      DateTime itemDay = DateTime.parse(element.date.toString());
      return isSameDay(itemDay, selectedDay);
    });
    if (itemList.isNotEmpty) {
      _filterItem.sink.add(itemList.first.items ?? []);
    } else {
      _filterItem.sink.add([]);
    }
  }
}

final shiftcalenderBloc = ShiftCalendarBloc();
