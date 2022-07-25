import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:table_calendar/table_calendar.dart';

import '../blocs/shift_confirmed_bloc.dart';
import '../blocs/shift_list_bloc.dart';
import '../eventutil/eventutil.dart';
import '../model/user_shift_calender.dart';
import '../resources/respository.dart';
import '../resources/token_provider.dart';
import '../ui/error/ConnectionFailedScreen.dart';
import '../utils/network_utils.dart';

class ShiftCalendarBloc {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController pageController;
  DateTime selectedDay = DateTime.now();
  DateTime focusDay = DateTime.now();
  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDate = DateTime.now();

  String? token = "";
  int devicePixelRatio = 3;
  int perPageItem = 3;
  int pageCount = 0;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  var selected = 0;
  var itemSelected = 0;
  final _repo = Repository();
  final _shiftCalender = PublishSubject<UserGetScheduleByYear>();
  final _filterItem = PublishSubject<List<Items>>();
  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;
  List<Item>? itemListAll = [];
  List<Items>? eventListByDate = [];

  Stream<UserGetScheduleByYear> get shiftCalendar => _shiftCalender.stream;

  Stream<List<Items>> get filteredByDate => _filterItem.stream;

  final Set<DateTime> selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  void initState(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      observe(context);
      getData(context);
      pageController = PageController(initialPage: 0);
      confirmBloc.pageCount = 3;
    });
  }

  void update(CalendarFormat f) {
    format = f;
    _visibility.sink.add(false);
  }

  void dispose() {
    // _shiftCalender.close();
  }

  List<Event> getEventsForDay(DateTime day) {
    List<Event> eventList = [];
    if (null != itemListAll) {
      var itemList = itemListAll?.where((element) {
        DateTime itemDay = DateTime.parse(element.date.toString());
        return isSameDay(itemDay, day);
      });
      if (itemList!.isNotEmpty) {
        var listItem = itemList.first;
        for (var item in listItem.items!) {
          eventList.add(Event(item.jobTitle??""));
        }
      }
    }
    return eventList;
  }

  void onDaySelected(DateTime selectedDay, DateTime focused) {
    focusedDay = focused;
    selectedDate = selectedDay;
    getSelectedDayEvent(selectedDate);
  }

  getSelectedDayEvent(DateTime selectedDay) {
    filterItemByDate(selectedDay);
  }

  void requestShift(Items items) {
    Items data = items;
    bloc.fetchUserJobRequest(data.rowId.toString());
  }

  Future getData(BuildContext context) async {
    token = await TokenProvider().getToken();
    bloc.token = await TokenProvider().getToken();
    confirmBloc.token = await TokenProvider().getToken();
    if (null != token) {
      if (await isNetworkAvailable()) {
        userGetScheduleByYear(token!, "2022");
      } else {
        Future.delayed(Duration.zero, () async {
          showInternetNotAvailable(context);
        });
      }
    }
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

  void observe(BuildContext context) {
    shiftCalendar.listen((event) {
      var itemList = event.response?.data?.item;
      final Set<DateTime> selectedDay = LinkedHashSet<DateTime>(
        equals: isSameDay,
        hashCode: getHashCode,
      );

      if (null != itemList) {
        for (var item in itemList) {
          if (item.items!.isNotEmpty) {
            debugPrint("Date:${item.date.toString()} - ${item.items!.length}");
            selectedDay.add(DateTime.parse(item.date.toString()));
          }
        }
        getSelectedDayEvent(selectedDate);
        selectedDays.clear();
        selectedDays.addAll(selectedDay);
      }
    });

    bloc.jobRequest.listen((event) {
      getData(context);
      String? message = event.response?.status?.statusMessage;
      Fluttertoast.showToast(msg: '$message');
    });
  }

  userGetScheduleByYear(String token, String year) async {
    _visibility.sink.add(true);
    UserGetScheduleByYear respo =
        await _repo.fetchuserscheduleyear(token, year);
    itemListAll = respo.response?.data?.item;
    if (!_shiftCalender.isClosed) {
      _visibility.sink.add(false);
      _shiftCalender.sink.add(respo);
    }
  }

  filterItemByDate(DateTime selectedDay) {
    _visibility.sink.add(true);
    var itemList = itemListAll!.where((element) {
      DateTime itemDay = DateTime.parse(element.date.toString());
      return isSameDay(itemDay, selectedDay);
    });
    if (itemList.isNotEmpty) {
      _filterItem.sink.add(itemList.first.items ?? []);
      _visibility.sink.add(false);
    } else {
      _filterItem.sink.add([]);
      _visibility.sink.add(false);
    }
  }
}

final shiftCalenderBloc = ShiftCalendarBloc();
