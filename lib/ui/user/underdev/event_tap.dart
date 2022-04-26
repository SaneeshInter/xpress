import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../home/find_shift_screen.dart';


class MyShiftCalender extends StatefulWidget {
  @override
  State<MyShiftCalender> createState() => _MyShiftCalenderState();
}

class _MyShiftCalenderState extends State<MyShiftCalender> {
  CalendarFormat format = CalendarFormat.month;
  DateTime SelectedDay = DateTime.now();
  DateTime focusDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Container(
                padding: EdgeInsets.all(12),
                child: Stack(
                  children: [
                    Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    TableCalendar(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FindShiftScreen()),
                        );

                        print(focusDay);
                      },
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        selectedDecoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(SelectedDay, date);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
