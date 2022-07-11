import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Constants/strings.dart';
import '../eventutil/eventutil.dart';
import '../model/common/manager_shift.dart';
import '../model/manager_shift_calendar_respo.dart';
import '../model/remove_manager_schedule.dart';
import '../resources/respository.dart';
import '../resources/token_provider.dart';
import '../ui/error/ConnectionFailedScreen.dart';
import '../ui/error/ErrorScreen.dart';
import '../utils/network_utils.dart';
import '../utils/utils.dart';

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
  final _getShiftCalendar = PublishSubject<ManagerGetScheduleByYear>();
  final _filterItems = PublishSubject<List<Items>>();
  List<Item>? itemListALl = [];
  List<Items>? eventListByDate = [];

  Stream<ManagerGetScheduleByYear> get managerCalendar =>
      _getShiftCalendar.stream;
  final _removeManagerSchedule =
      PublishSubject<RemoveManagerScheduleResponse>();

  Stream<RemoveManagerScheduleResponse> get removeShift =>
      _removeManagerSchedule.stream;

  Stream<List<Items>> get filtered => _filterItems.stream;

  final Set<DateTime> selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  Future deleteShift(rowId, context) async {
    debugPrint("deleteShift 2 $rowId");
    String? token = await TokenProvider().getToken();
    managercalendarBloc.fetchRemoveManager(token!, rowId.toString(), context);
  }

  void update(CalendarFormat f) {
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
        Future.delayed(Duration.zero,(){
        showInternetNotAvailable(context);
        });

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
    removeShift.listen((event) {
      debugPrint(event.response?.status?.statusCode.toString());

      _visibility.sink.add(false);

      var message = event.response?.status?.statusMessage;

      if (event.response?.status?.statusCode == 200) {
        getData(context);
        Fluttertoast.showToast(msg: '$message');
      } else {
        showAlertDialoge(context, title: Txt.failed, message: message!);
      }
    });
    managerCalendar.listen((event) {
      if (null != event.response?.data) {
        var itemList = event.response?.data?.item;
        final Set<DateTime> selectedDay = LinkedHashSet<DateTime>(
          equals: isSameDay,
          hashCode: getHashCode,
        );
        for (var item in itemList!) {
          if (item.items!.isNotEmpty) {
            selectedDay.add(DateTime.parse(item.date.toString()));
          }
        }

        selectedDays.clear();
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

    if (null != itemListALl) {
      var itemList = managercalendarBloc.itemListALl?.where((element) {
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
    ManagerGetScheduleByYear? respo =
        await _repo.fetchmanagerscheduleyear(token, year);
    itemListALl = respo?.response?.data?.item;
    if (!_getShiftCalendar.isClosed) {
      _visibility.sink.add(false);
      _getShiftCalendar.sink.add(respo!);
    }
  }

  dispose() {
    _getShiftCalendar.close();
  }

  filterItemByDates(DateTime selectedDay) {
    var itemList = itemListALl!.where((element) {
      DateTime itemDay = DateTime.parse(element.date.toString());
      return isSameDay(itemDay, selectedDay);
    });
    if (itemList.isNotEmpty) {
      _filterItems.sink.add(itemList.first.items ?? []);
    } else {
      _filterItems.sink.add([]);
    }
  }

  fetchRemoveManager(String token, String rowid, BuildContext context) async {
    debugPrint(rowid);
    RemoveManagerScheduleResponse list =
        await _repo.fetchRemoveManager(token, rowid);

    _removeManagerSchedule.sink.add(list);
  }
}

final managercalendarBloc = ManagerShiftCalendarBloc();
