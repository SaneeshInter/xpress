import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xpresshealthdev/Constants/strings.dart';

import '../../../blocs/shift_confirmed_bloc.dart';

import '../../../blocs/shift_list_bloc.dart';
import '../../../blocs/user_shift_calendar.dart';
import '../../../eventutil/eventutil.dart';
import '../../../model/user_shift_calender.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/network_utils.dart';
import '../../../utils/utils.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/shift_list_calender_widget.dart';
import '../detail/shift_detail.dart';

class FindshiftCalendar extends StatefulWidget {
  const FindshiftCalendar({Key? key}) : super(key: key);

  @override
  _FindshiftState createState() => _FindshiftState();
}

class _FindshiftState extends State<FindshiftCalendar> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController pageController;
  DateTime SelectedDay = DateTime.now();
  DateTime focusDay = DateTime.now();
  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime selectedDate = DateTime.now();
  var _scrollController;
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  @override
  void dispose() {
    super.dispose();
    shiftcalenderBloc.dispose();
  }

  @override
  void didUpdateWidget(covariant FindshiftCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future getData() async {
    shiftcalenderBloc.token = await TokenProvider().getToken();
    if (null != shiftcalenderBloc.token) {
      if (await isNetworkAvailable()) {
        shiftcalenderBloc.userGetScheduleByYear(shiftcalenderBloc.token, "2022");
      } else {
        showInternetNotAvailable();
      }
    }
  }

  void observe() {
    shiftcalenderBloc.shiftcalendar.listen((event) {
      var itemList = event.response?.data?.item;
      final Set<DateTime> selectedDay = LinkedHashSet<DateTime>(
        equals: isSameDay,
        hashCode: getHashCode,
      );

      if(null!=itemList)
        {
          for (var item in itemList) {
            selectedDay.add(DateTime.parse(item.date.toString()));
          }
          getSelectedDayEvent(selectedDate);
          setState(() {
            _selectedDays.addAll(selectedDay);
          });
        }

    });

    bloc.jobrequest.listen((event) {
      getData();
      confirmBloc.fetchUserViewRequest(shiftcalenderBloc.token);
      String? message = event.response?.status?.statusMessage;
      showAlertDialoge(context, message: message!, title: Txt
      .request);
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
    confirmBloc.pageCount = 3;
  }

  List<Event> _getEventsForDay(DateTime day) {
    List<Event> eventList = [];
    if(null!=shiftcalenderBloc.itemListAll)
      {
        var itemList = shiftcalenderBloc.itemListAll?.where((element) {
          DateTime itemDay = DateTime.parse(element.date.toString());
          return isSameDay(itemDay, day);
        });
        if (itemList!.isNotEmpty) {
          var listItem = itemList.first;
          for (var item in listItem.items!) {
            eventList.add(Event(item.jobTitle!));
          }
        }
      }
    return eventList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          getData();
        },
        label: const Text(Txt.refresh),
        icon: const Icon(Icons.refresh),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Constants.colors[9],
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                child: Container(
                  decoration: const BoxDecoration(
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
                    // onPageChanged: (date){
                    //   getData();
                    // },
                    onDaySelected: _onDaySelected,
                    selectedDayPredicate: (day) {
                      return _selectedDays.contains(day);
                    },
                    calendarBuilders: CalendarBuilders(markerBuilder:
                        (BuildContext context, DateTime datetime,
                            List<Event> list) {
                      if (list.isNotEmpty) {
                        return Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(
                                      list.length.toString() +Txt.shifts,
                                      style: TextStyle(
                                          fontSize: 7.sp,
                                          color: Constants.colors[38],
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )),
                            ),
                          ],
                        );
                      }
                    }),
                    eventLoader: _getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    daysOfWeekVisible: true,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      markerSize: 4,

                      cellMargin: EdgeInsets.all(11),
                      canMarkersOverflow: false,
                      selectedDecoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Constants.colors[4],
                              Constants.colors[3],
                            ]),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              NotificationListener(
                onNotification: (notification) {
                  //print(_scrollController.position);
                  // Return true to cancel the notification bubbling. Return false (or null) to
                  // allow the notification to continue to be dispatched to further ancestors.
                  return true;
                },
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: StreamBuilder(
                        stream: shiftcalenderBloc.filteredBydate,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Items>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              shrinkWrap: true,
                              controller: _scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                var items = snapshot.data?[index];
                                if (null != items) {
                                  return Column(
                                    children: [
                                      ShiftListCalenderWidget(
                                        items: items,
                                        token: shiftcalenderBloc.token,
                                        onTapDelete: () {},
                                        onTapViewMap: () {},
                                        onTapView: (item) {
                                          if (items is Items) {
                                            Items data = items;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShiftDetailScreen(
                                                        shift_id: data.rowId
                                                            .toString(),
                                                        isCompleted: false,
                                                      )),
                                            );
                                          }
                                        },
                                        onTapBook: (item) {
                                          requestShift(items);
                                        },
                                        onTapEdit: () {
                                          print("Tapped calendar");
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
              ),
            ],
          ),
          Center(
            child: StreamBuilder(
              stream: shiftcalenderBloc.visible,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return const Center(child: LoadingWidget());
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            ),
          ),
          Center(
            child: StreamBuilder(
              stream: bloc.visible,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return const Center(child: LoadingWidget());
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            ),
          ),
          Center(
            child: StreamBuilder(
              stream: confirmBloc.visible,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return const Center(child: LoadingWidget());
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      selectedDate = selectedDay;
      getSelectedDayEvent(selectedDate);
    });
  }

  getSelectedDayEvent(DateTime selectedDay) {
    shiftcalenderBloc.filterItemByDate(selectedDay);
  }

  void requestShift(Items items) {
      Items data = items;
      bloc.fetchuserJobRequest(data.rowId.toString());
  }
}
