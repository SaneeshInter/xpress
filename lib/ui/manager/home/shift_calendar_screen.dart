import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../utils/constants.dart';
import '../../widgets/my_scroll_behavior.dart';


class ShiftCalendarScreen extends StatefulWidget {
  const ShiftCalendarScreen({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _ProfileState extends State<ShiftCalendarScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
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

      backgroundColor: Constants.colors[9],
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime(2030),
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
                  selectedDay = selectDay;
                  focusDay = focusDay;
                });
                debugPrint(focusDay.toString());
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
                return isSameDay(selectedDay, date);
              },
            ),
          ),
        ),
      ),
    );
  }
}




