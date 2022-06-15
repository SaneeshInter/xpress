
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../Constants/strings.dart';

import '../../../blocs/shift_confirmed_bloc.dart';

import '../../../blocs/shift_list_bloc.dart';
import '../../../blocs/user_shift_calendar.dart';
import '../../../eventutil/eventutil.dart';
import '../../../model/user_shift_calender.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/shift_list_calender_widget.dart';
import '../detail/shift_detail.dart';

class FindShiftCalendar extends StatelessWidget {
  const FindShiftCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    shiftCalenderBloc.initState(context);
    return Scaffold(
      key: shiftCalenderBloc.scaffoldKey,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          shiftCalenderBloc.getData(context);
        },
        label: const Text(Txt.refresh),
        icon: const Icon(Icons.refresh),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Constants.colors[9],
      body: Stack(
        children: [
          NestedScrollView(
          floatHeaderSlivers:true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                      addAutomaticKeepAlives: true,
                      [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: StreamBuilder(
                                stream: shiftCalenderBloc.shiftCalendar,
                                builder: (context, snapshot) {
                                  return StreamBuilder(
                                    stream: shiftCalenderBloc.visible,
                                    builder: (context, snapshot) {
                                      return TableCalendar(
                                        focusedDay: shiftCalenderBloc.focusedDay,
                                        firstDay: DateTime(2022),
                                        lastDay: DateTime(2050),
                                        calendarFormat: shiftCalenderBloc.format,
                                        onFormatChanged: (CalendarFormat format) {
                                           shiftCalenderBloc.update( format);
                                        },

                                        onDaySelected:  shiftCalenderBloc.onDaySelected,
                                        selectedDayPredicate: (day) {
                                          return shiftCalenderBloc.selectedDays.contains(day);
                                        },
                                        calendarBuilders: CalendarBuilders(markerBuilder:
                                            (BuildContext context, DateTime datetime,
                                            List<Event> list) {
                                          if (list.isNotEmpty) {
                                            return Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.topCenter,
                                                  child: ColoredBox(
                                                      color: Colors.transparent,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 4),
                                                        child: Text(
                                                          list.length.toString() +
                                                              Txt.shifts,
                                                          style: TextStyle(
                                                              fontSize: 7.sp,
                                                              color: Constants.colors[38],
                                                              fontWeight:
                                                              FontWeight.w600),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            );
                                          }
                                          return null;
                                        }),
                                        eventLoader: shiftCalenderBloc.getEventsForDay,
                                        startingDayOfWeek: StartingDayOfWeek.sunday,
                                        daysOfWeekVisible: true,
                                        headerStyle: const HeaderStyle(
                                          formatButtonVisible: false,
                                          titleCentered: true,
                                        ),
                                        calendarStyle: CalendarStyle(
                                          isTodayHighlighted: true,
                                          markerSize: 4,
                                          cellMargin: const EdgeInsets.all(11),
                                          canMarkersOverflow: false,
                                          markersAutoAligned: true,
                                          disabledDecoration: const BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5.0)),
                                          ),
                                          rowDecoration: const BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5.0)),
                                          ),
                                          outsideDecoration: const BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5.0)),
                                          ),

                                          weekendDecoration: const BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5.0)),
                                          ),markerDecoration: const BoxDecoration(

                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(5.0)),
                                        ),

                                          holidayDecoration: const BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5.0)),
                                          ),
                                          todayDecoration: const BoxDecoration(
                                            color: Color(0xFFAACFE5),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5.0)),
                                          ),
                                          defaultDecoration: const BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5.0)),
                                          ),

                                          rangeStartDecoration: const BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5.0)),
                                          ),

                                          selectedDecoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Constants.colors[4],
                                                  Constants.colors[3],
                                                ]),
                                            shape: BoxShape.rectangle,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                        ),
                                      );
                                    }
                                  );
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder(
                  stream: shiftCalenderBloc.filteredByDate,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Items>> snapshot) {
                    if (snapshot.hasData) {
                      return NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overScroll) {
                          overScroll.disallowIndicator();
                          return false;
                        },
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.length,
                          shrinkWrap: true,

                          itemBuilder: (BuildContext context, int index) {
                            var items = snapshot.data?[index];
                            if (null != items) {
                              return Column(
                                children: [
                                  ShiftListCalenderWidget(
                                    items: items,
                                    token: shiftCalenderBloc.token,
                                    onTapDelete: () {},
                                    onTapViewMap: () {},
                                    onTapView: (item) {
                                      if (item is Items) {
                                        Items data = item;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShiftDetailScreen(
                                                    shift_id:
                                                    data.rowId.toString(),
                                                    isCompleted: false,
                                                  )),
                                        );
                                      }
                                    },
                                    onTapBook: (item) {
                                      shiftCalenderBloc.requestShift(items);
                                    },
                                    onTapEdit: () {
                                      debugPrint("Tapped calendar");
                                    },
                                    key: null,
                                  ),
                                  SizedBox(
                                      height: screenHeight(context,
                                          dividedBy: 100)),
                                ],
                              );
                            } else {
                              debugPrint("items.hospital");
                              return const SizedBox();
                            }
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return const SizedBox();
                  }),
            ),
          ),
          Center(
            child: StreamBuilder(
              stream: shiftCalenderBloc.visible,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return const Center(child: LoadingWidget());
                  } else {
                    return const SizedBox();
                  }
                } else {
                  return const SizedBox();
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
                    return const SizedBox();
                  }
                } else {
                  return const SizedBox();
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
                    return const SizedBox();
                  }
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
