import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xpresshealthdev/blocs/manager_shift_calendar.dart';
import 'package:xpresshealthdev/model/manager_shift_calendar_respo.dart';

import '../../../eventutil/eventutil.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/network_utils.dart';
import '../../../utils/utils.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/manager_list_calendar.dart';
import 'create_shift_screen.dart';

class ManagerfindshiftCalendar extends StatefulWidget {
  const ManagerfindshiftCalendar({Key? key}) : super(key: key);

  @override
  _FindshiftStates createState() => _FindshiftStates();
}

class _FindshiftStates extends State<ManagerfindshiftCalendar> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int devicePixelRatio = 3;
  int perPageItem = 3;
  int pageCount = 0;
  var token;
  bool visibility = false;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  var selected = 0;
  var itemSelected = 0;
  late PageController pageController;
  DateTime SelectedDay = DateTime.now();
  DateTime focusDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  final ScrollController _controller = ScrollController();
  DateTime _focusedDay = DateTime.now();

  // Using a `LinkedHashSet` is recommended due to equality comparison override
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  @override
  void didUpdateWidget(covariant ManagerfindshiftCalendar oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  Future getData() async {
    token = await TokenProvider().getToken();
    if (null != token) {
      if (await isNetworkAvailable()) {
        setState(() {
          visibility = true;
        });
        managercalendarBloc.managerGetScheduleByYear(token, "2022");
      } else {
        showInternetNotAvailable();
      }
    }
  }

  void observe() {
    managercalendarBloc.managercalendar.listen((event) {
      var itemList = event.response?.data?.item;
      final Set<DateTime> selectedDay = LinkedHashSet<DateTime>(
        equals: isSameDay,
        hashCode: getHashCode,
      );
      for (var item in itemList!) {
        selectedDay.add(DateTime.parse(item.date.toString()));
      }
      setState(() {
        visibility = false;
        _selectedDays.addAll(selectedDay);
      });
    });
  }

  Future<void> showInternetNotAvailable() async {
    int respo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionFailedScreen()),
    );

    if (respo == 1) {
      getData();
    }
  }

  @override
  void initState() {
    super.initState();
    observe();
    getData();
    pageController = PageController(initialPage: 0);
    pageCount = 3;
  }

  List<Event> _getEventsForDay(DateTime day) {
    List<Event> eventList = [];
    var itemList = managercalendarBloc.itemlListALl!.where((element) {
      DateTime itemDay = DateTime.parse(element.date.toString());
      return isSameDay(itemDay, day);
    });
    if (itemList.isNotEmpty) {
      var listItem = itemList.first;
      for (var item in listItem.items!) {
        eventList.add(Event(item.jobTitle!));
      }
    }

    return eventList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Constants.colors[9],
        //backgroundColor: Constants.colors[9],
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: TableCalendar(
                      focusedDay: _focusedDay,
                      firstDay: DateTime(2022),
                      lastDay: DateTime(2050),
                      calendarFormat: format,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          format = _format;
                        });
                      },
                      onDaySelected: _onDaySelected,
                      selectedDayPredicate: (day) {
                        return _selectedDays.contains(day);
                      },
                      eventLoader: _getEventsForDay,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      daysOfWeekVisible: true,
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        markerSize: 4,
                        selectedDecoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,

                          // borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: StreamBuilder(
                        stream: managercalendarBloc.filtered,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Items>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                var items = snapshot.data![index];
                                if (null != items) {
                                  return Column(
                                    children: [
                                      ManagerListCalenderWidget(
                                        items: items,
                                        token: token,
                                        onTapDelete: () {},
                                        onTapViewMap: () {},
                                        onTapView: (item) {
                                          if (items is Items) {
                                            Items data = items;
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           ShiftDetailManagerScreen(shift_id: widget.items.rowId.toString(),)),
                                            // );
                                          }
                                        },
                                        onTapBook: (item) {
                                          // requestShift(items);
                                        },
                                        onTapEdit: () {
                                          print("Tapped");
                                        },
                                        key: null,
                                      ),
                                      SizedBox(
                                          height: screenHeight(context,
                                              dividedBy: 100)),
                                    ],
                                  );
                                } else {
                                  print("items.hospital");
                                  return Container();
                                }
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return Container();
                        }),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            Center(
              child: Visibility(
                visible: visibility,
                child: Container(
                  width: 100.w,
                  height: 80.h,
                  child: const Center(
                    child: LoadingWidget(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.colors[4],
          foregroundColor: Constants.colors[0],
          onPressed: () {   Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateShiftScreen()),
          );},
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      print("selectedDay");
      print(selectedDay);
      // if (_selectedDays.contains(selectedDay)) {
      //   _selectedDays.remove(selectedDay);
      // } else {
      //   _selectedDays.add(selectedDay);
      // }

      managercalendarBloc.filterItemByDates(selectedDay);
    });
  }
}
