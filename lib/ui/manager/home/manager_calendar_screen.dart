import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../blocs/manager_shift_calendar.dart';
import '../../../eventutil/eventutil.dart';
import '../../../model/common/manager_shift.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/manager_list_calendar.dart';
import '../create_shift_screen_update.dart';

class ManagerFindShiftCalendar extends StatelessWidget {
  const ManagerFindShiftCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    managercalendarBloc.initState(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // key: managercalendarBloc.scaffoldKey,
        backgroundColor: Constants.colors[9],
        //backgroundColor: Constants.colors[9],
        body: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 10.0,
                                bottom: 10.0),
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
                                stream: managercalendarBloc.managercalendar,
                                builder: (context, snapshot) {
                                  return StreamBuilder(
                                    stream: managercalendarBloc.visible,
                                    builder: (context, snapshot) {
                                      return TableCalendar(
                                        focusedDay: managercalendarBloc.focusedDay,
                                        firstDay: DateTime(2022),
                                        lastDay: DateTime(2050),
                                        calendarFormat: managercalendarBloc.format,
                                        onFormatChanged: (CalendarFormat format) {
                                            managercalendarBloc.update(format);
                                        },
                                        onDaySelected:
                                        managercalendarBloc.onDaySelected,
                                        selectedDayPredicate: (day) {

                                          return managercalendarBloc.selectedDays
                                              .contains(day);
                                        },
                                        calendarBuilders: CalendarBuilders(
                                            markerBuilder: (BuildContext context,
                                                DateTime datetime, List<Event> list) {
                                              if (list.isNotEmpty) {
                                                return Stack(
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.topCenter,
                                                      child: Container(
                                                          color: Colors.transparent,
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets.symmetric(
                                                                horizontal: 4),
                                                            child: Text(
                                                              "${list.length} Shift",
                                                              style: TextStyle(
                                                                  fontSize: 7.sp,
                                                                  color:
                                                                  Constants.colors[38],
                                                                  fontWeight:
                                                                  FontWeight.w600),
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                );
                                              }
                                            }),
                                        eventLoader:
                                        managercalendarBloc.getEventsForDay,
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
                                          holidayDecoration: const BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5.0)),
                                          ),
                                          todayDecoration: const BoxDecoration(
                                            color: Color(0xFF1CB34F),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5.0)),
                                          ),
                                          defaultDecoration: const BoxDecoration(
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
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder(
                          stream: managercalendarBloc.filtered,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Items>> snapshot) {
                            if (snapshot.hasData) {
                              return NotificationListener<OverscrollIndicatorNotification>(
                                onNotification: (overScroll) {
                                  overScroll.disallowIndicator();
                                  return false;
                                },
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    managercalendarBloc.getData(context);
                                  },
                                  child: ListView.builder(
                                    itemCount: snapshot.data?.length,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      var items = snapshot.data![index];
                                      if (null != items) {
                                        return Column(
                                          children: [
                                            ManagerListCalenderWidget(
                                              items: items,
                                              onTapView: () {},
                                              key: null,
                                              onTapEdit: (item) {
                                                print(item);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreateShiftScreenUpdate(
                                                              shiftItem: items,
                                                            ))).then((value) =>
                                                    managercalendarBloc
                                                        .getData(context));
                                              },
                                              onTapDelete: (rowId) {
                                                print(rowId);

                                                  // managercalendarBloc.visibility=true;

                                                managercalendarBloc
                                                    .deleteShift(rowId);
                                              },
                                              onTapBook: () {},
                                              onTapViewMap: () {},
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
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            return const SizedBox();
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Center(
              child: StreamBuilder(
                stream: managercalendarBloc.visible,
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
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.colors[4],
          foregroundColor: Constants.colors[0],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateShiftScreenUpdate()),
            ).then((value) => managercalendarBloc.getData(context));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}



// class ManagerfindshiftCalendar extends StatefulWidget {
//   const ManagerfindshiftCalendar({Key? key}) : super(key: key);
//
//   @override
//   _FindshiftStates createState() => _FindshiftStates();
// }
//
// class _FindshiftStates extends State<ManagerfindshiftCalendar> {
//   // @override
//   // void didUpdateWidget(covariant ManagerfindshiftCalendar oldWidget) {
//   //   // TODO: implement didUpdateWidget
//   //   super.didUpdateWidget(oldWidget);
//   // }
//
//
// }
