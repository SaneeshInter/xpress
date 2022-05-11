import 'dart:collection';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../eventutil/eventutil.dart';
import '../../../model/user_getschedule_bydate.dart';
import '../../../utils/colors_util.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../underdev/event_tap.dart';

class FindshiftCalendar extends StatefulWidget {
  const FindshiftCalendar({Key? key}) : super(key: key);

  @override
  _FindshiftState createState() => _FindshiftState();
}

class _FindshiftState extends State<FindshiftCalendar> {
  List<Items> list = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int devicePixelRatio = 3;
  int perPageItem = 3;
  int pageCount = 0;
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
  void didUpdateWidget(covariant FindshiftCalendar oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    pageCount = 3;
    _selectedDays.add(DateTime.parse("2022-05-12"));
    _selectedDays.add(DateTime.parse("2022-05-12"));
    _selectedDays.add(DateTime.parse("2022-05-13"));
    _selectedDays.add(DateTime.parse("2022-05-14"));
    _selectedDays.add(DateTime.parse("2022-05-15"));
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    print("day");
    print(day.toString());

    return kEvents[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: HexColor("#ffffff"),
        //backgroundColor: Constants.colors[9],
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                  focusedDay: SelectedDay,
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
                  // onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  //   setState(() {
                  //     SelectedDay = selectDay;
                  //     focusDay = focusDay;
                  //   });
                  //   // Navigator.push(
                  //   //   context,
                  //   //   // MaterialPageRoute(builder: (context) => FindShiftScreen()),
                  //   // );
                  //   print(focusDay);
                  // },
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return  Container(
                    width: screenWidth(context, dividedBy: 1),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, dividedBy: 25),
                        vertical: screenHeight(context, dividedBy: 70)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            // if (null != widget.items.hospital)
                              AutoSizeText(
                                "Hospital",
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            SizedBox(height: screenHeight(context, dividedBy: 120)),

                              Text(
                                "From 10.20"
                                    " To  12.30" ,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                              ),
                            SizedBox(height: screenHeight(context, dividedBy: 120)),
                              Text(
                                "Nurse" ,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Constants.colors[3],
                                    fontWeight: FontWeight.w500),
                              ),
                          ]),
                          Spacer(),
                        ]),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }


    });

    // _selectedEvents.value = _getEventsForDays(_selectedDays);
  }
}
