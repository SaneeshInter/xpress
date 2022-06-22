import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:table_calendar/table_calendar.dart';
import '../eventutil/eventutil.dart';
import '../resources/respository.dart';

import '../model/common/manager_shift.dart';
import '../model/manager_shift_calendar_respo.dart';
import '../model/remove_manager_schedule.dart';
import '../resources/token_provider.dart';
import '../ui/error/ConnectionFailedScreen.dart';
import '../ui/error/ErrorScreen.dart';
import '../utils/network_utils.dart';

class ManagerShiftCalendarBloc {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int devicePixelRatio = 3;
  int perPageItem = 3;
  int pageCount = 0;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  var selected = 0;
  var itemSelected = 0;
  var token;
  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;
  late PageController pageController;
  DateTime focusDay = DateTime.now();
  CalendarFormat format = CalendarFormat.twoWeeks;
  final ScrollController controller = ScrollController();
  DateTime focusedDay = DateTime.now();
  DateTime selectedCalenderDay = DateTime.now();
  final _repo = Repository();
  final _getshiftcalendar = PublishSubject<ManagerGetScheduleByYear>();
  final _filterItems = PublishSubject<List<Items>>();
  List<Item>? itemlListALl = [];
  List<Items>? eventListByDate = [];
  Stream<ManagerGetScheduleByYear> get managercalendar => _getshiftcalendar.stream;
  final _removeManagerSchedule =
  PublishSubject<RemoveManagerScheduleResponse>();

  Stream<RemoveManagerScheduleResponse> get removeshift => _removeManagerSchedule.stream;

  Stream<List<Items>> get filtered => _filterItems.stream;
  final Set<DateTime> selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  Future deleteShift(rowId) async {
    String? token = await TokenProvider().getToken();
    managercalendarBloc.fetchRemoveManager(token!, rowId.toString());
  }
  void update(CalendarFormat f){
    format = f;
    _visibility.sink.add(false);
  }
  void onDaySelected(DateTime selectedDay, DateTime selected) {

    focusedDay = selected;
      selectedCalenderDay = selected;
      debugPrint("selectedDay");
      debugPrint(selectedDay.toString());
      filterItemByDates(selectedDay);
      _visibility.sink.add(false);
  }
  Future getData(BuildContext context) async {
    token = await TokenProvider().getToken();
    if (null != token) {
      if (await isNetworkAvailable()) {

          _visibility.sink.add(false);

       await managerGetScheduleByYear(token, "2022");
          _visibility.sink.add(false);
      } else {
        showInternetNotAvailable(context);
      }
    }
  }

  void showError(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ErrorScreen()),
    );
  }

  void observe(BuildContext context) {
    removeshift.listen((event) {
      debugPrint(event.response?.status?.statusCode.toString());

      _visibility.sink.add(false);


      var message = event.response?.status?.statusMessage;
      // Fluttertoast.showToast(msg: '$message');
      if (event.response?.status?.statusCode == 200) {
        getData(context);
      }
    });
    managercalendar.listen((event) {
      if (null != event.response?.data) {
        var itemList = event.response?.data?.item;
        final Set<DateTime> selectedDay = LinkedHashSet<DateTime>(
          equals: isSameDay,
          hashCode: getHashCode,
        );
        for (var item in itemList!) {
          selectedDay.add(DateTime.parse(item.date.toString()));
        }


          selectedDays.addAll(selectedDay);

        onDaySelected(selectedCalenderDay, selectedCalenderDay);
      } else {

        _visibility.sink.add(false);

        showError(context);
      }
    });
  }

  Future<void> showInternetNotAvailable(BuildContext context) async {
    int res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionFailedScreen()),
    );
    if (res == 1) {
      Future.delayed(Duration.zero).then((_) {
        getData(context);
      });
    }
  }

  void initState(BuildContext context) {

    observe(context);
    getData(context);
    pageController = PageController(initialPage: 0);
    pageCount = 3;
  }

  List<Event> getEventsForDay(DateTime day) {
    List<Event> eventList = [];

    if (null != itemlListALl) {
      var itemList = managercalendarBloc.itemlListALl?.where((element) {
        DateTime itemDay = DateTime.parse(element.date.toString());
        return isSameDay(itemDay, day);
      });

      if (itemList!.isNotEmpty) {
        var listItem = itemList.first;
        eventList.clear();
        for (var item in listItem.items!) {
          eventList.add(Event(item.jobTitle!));
        }
      }
    }

    return eventList;
  }

  managerGetScheduleByYear(String token, String year) async {
    _visibility.sink.add(true);
    ManagerGetScheduleByYear? respo =await _repo.fetchmanagerscheduleyear(token, year);
    itemlListALl = respo?.response?.data?.item;
    if (!_getshiftcalendar.isClosed) {
      _visibility.sink.add(false);
      _getshiftcalendar.sink.add(respo!);
    }

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

  fetchRemoveManager(String token, String rowid) async {
    debugPrint(rowid);
    RemoveManagerScheduleResponse list =
    await _repo.fetchRemoveManager(token, rowid);
    _removeManagerSchedule.sink.add(list);
  }
}
final managercalendarBloc = ManagerShiftCalendarBloc();
