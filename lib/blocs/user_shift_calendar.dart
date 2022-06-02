import 'package:rxdart/rxdart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xpresshealthdev/resources/respository.dart';

import '../model/user_shift_calender.dart';

class ShiftCalendarBloc {
  var token;
  int devicePixelRatio = 3;
  int perPageItem = 3;
  int pageCount = 0;
  bool visibility = false;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  var selected = 0;
  var itemSelected = 0;
  final _repo = Repository();
  final _shiftcalender = PublishSubject<UserGetScheduleByYear>();
  final _filterItem = PublishSubject<List<Items>>();

  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;

  List<Item>? itemListAll = [];

  List<Items>? eventListByDate = [];

  Stream<UserGetScheduleByYear> get shiftcalendar => _shiftcalender.stream;

  Stream<List<Items>> get filteredBydate => _filterItem.stream;

  userGetScheduleByYear(String token, String year) async {
    _visibility.add(true);
    UserGetScheduleByYear respo =
        await _repo.fetchuserscheduleyear(token, year);
    itemListAll = respo.response?.data?.item;
    if (!_shiftcalender.isClosed) {
      _visibility.add(false);
      _shiftcalender.sink.add(respo);
    }
  }

  dispose() {
    _shiftcalender.close();
  }

  filterItemByDate(DateTime selectedDay) {
    _visibility.add(true);
    var itemList = itemListAll!.where((element) {
      DateTime itemDay = DateTime.parse(element.date.toString());
      return isSameDay(itemDay, selectedDay);
    });
    if (itemList.isNotEmpty) {
      _filterItem.sink.add(itemList.first.items ?? []);
      _visibility.add(false);
    } else {
      _filterItem.sink.add([]);
      _visibility.add(false);
    }
  }










}

final shiftcalenderBloc = ShiftCalendarBloc();
