import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../user/common/app_bar.dart';
import '../../user/common/side_menu.dart';
import '../../../utils/constants.dart';


class ShiftCalendarScreen extends StatefulWidget {
  const ShiftCalendarScreen({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _ProfileState extends State<ShiftCalendarScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  CalendarFormat format = CalendarFormat.month;
  DateTime SelectedDay = DateTime.now();
  DateTime focusDay = DateTime.now();

  @override
  void didUpdateWidget(covariant ShiftCalendarScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: SideMenu(),
      ),
      appBar: AppBarCommon(
        _scaffoldKey,
        scaffoldKey: _scaffoldKey,
      ),
      backgroundColor: Constants.colors[9],
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: TableCalendar(
                focusedDay: SelectedDay,
                firstDay: DateTime(1990),
                lastDay: DateTime(2050),
                calendarFormat: format,
                onFormatChanged: (CalendarFormat _format) {
                  setState(() {
                    format = _format;
                  });
                },
                startingDayOfWeek: StartingDayOfWeek.sunday,
                daysOfWeekVisible: true,
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    SelectedDay = selectDay;
                    focusDay = focusDay;
                  });
                  print(focusDay);
                },
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,

                  selectedDecoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(SelectedDay, date);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
