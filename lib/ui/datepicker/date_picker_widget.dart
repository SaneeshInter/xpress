import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'date_widget.dart';
import 'extra/color.dart';
import 'extra/style.dart';
import 'tap.dart';

class DatePicker extends StatefulWidget {
  /// Start Date in case user wants to show past dates
  /// If not provided calendar will start from the initialSelectedDate
  final DateTime startDate;

  /// Width of the selector
  final double width;

  /// Height of the selector
  final double height;

  /// DatePicker Controller
  final DatePickerController? controller;

  /// Text color for the selected Date
  final Color selectedTextColor;

  /// Background color for the selector
  final Color selectionColor;

  /// Text Color for the deactivated dates
  final Color deactivatedColor;

  /// TextStyle for Month Value
  final TextStyle monthTextStyle;

  /// TextStyle for day Value
  final TextStyle dayTextStyle;

  final TextStyle selectedDayStyle;

  final TextStyle selectedDateStyle;

  /// TextStyle for the date Value
  final TextStyle dateTextStyle;

  /// Current Selected Date
  final DateTime? /*?*/ initialSelectedDate;

  /// Contains the list of inactive dates.
  /// All the dates defined in this List will be deactivated
  final List<DateTime>? inactiveDates;

  /// Contains the list of active dates.
  /// Only the dates in this list will be activated.
  final List<DateTime>? activeDates;

  /// Callback function for when a different date is selected
  final DateChangeListener? onDateChange;

  /// Max limit up to which the dates are shown.
  /// Days are counted from the startDate
  final int daysCount;

  /// Locale for the calendar default: en_us
  final String locale;

  final FixedExtentScrollController itemController;

  DatePicker(
    this.startDate, {
    Key? key,
    this.width = 40,
    this.height = 80,
    this.controller,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.deactivatedColor = AppColors.defaultDeactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 500,
    this.onDateChange,
    this.locale = "en_US",
    this.selectedDayStyle = defaultSelectedTextStyle,
    this.selectedDateStyle = defaultSelectedTextStyle,
    required this.itemController,
  }) : assert(
            activeDates == null || inactiveDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time.");

  @override
  State<StatefulWidget> createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _currentDate;
  final ScrollController _controller = ScrollController();

  late final TextStyle selectedDateStyle;
  late final TextStyle selectedMonthStyle;
  late final TextStyle selectedDayStyle;
  late final TextStyle deactivatedDateStyle;
  late final TextStyle deactivatedMonthStyle;
  late final TextStyle deactivatedDayStyle;
  var itemSelected = 0;
  @override
  void initState() {
    // Init the calendar locale
    initializeDateFormatting(widget.locale, null);
    // Set initial Values
    _currentDate = widget.initialSelectedDate;

    if (widget.controller != null) {
      widget.controller!.setDatePickerState(this);
    }
    this.selectedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.selectedTextColor);
    this.selectedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.selectedTextColor);
    this.selectedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.selectedTextColor);

    this.deactivatedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.deactivatedColor);
    this.deactivatedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.deactivatedColor);
    this.deactivatedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.deactivatedColor);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Column(
        children: [
          Container(
            height: widget.height,
            child: RotatedBox(
                quarterTurns: -1,
                child: ListWheelScrollView(
                  controller: widget.itemController,
                  diameterRatio: 10,
                  // useMagnifier: true,
                  offAxisFraction: 0,
                  onSelectedItemChanged: (x) {
                    setState(() {
                      itemSelected = x;
                      debugPrint("selected");
                      debugPrint(x.toString());

                      DateTime _date = widget.startDate.add(Duration(days: x));
                      DateTime date =
                          new DateTime(_date.year, _date.month, _date.day);
                      if (widget.onDateChange != null) {
                        widget.onDateChange!(date, x);
                      }
                    });
                  },
                  itemExtent: widget.width,
                  children: List.generate(
                      widget.daysCount,
                      (x) => RotatedBox(
                          quarterTurns: 1,
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              child: StreamBuilder<Object>(
                                  stream: null,
                                  builder: (context, snapshot) {
                                    DateTime date;
                                    DateTime _date =
                                        widget.startDate.add(Duration(days: x));
                                    date = new DateTime(
                                        _date.year, _date.month, _date.day);

                                    bool isDeactivated = false;

                                    // check if this date needs to be deactivated for only DeactivatedDates
                                    if (widget.inactiveDates != null) {
//            debugPrint("Inside Inactive dates.");
                                      for (DateTime inactiveDate
                                          in widget.inactiveDates!) {
                                        if (_compareDate(date, inactiveDate)) {
                                          isDeactivated = true;
                                          break;
                                        }
                                      }
                                    }

                                    // check if this date needs to be deactivated for only ActivatedDates
                                    if (widget.activeDates != null) {
                                      isDeactivated = true;
                                      for (DateTime activateDate
                                          in widget.activeDates!) {
                                        // Compare the date if it is in the
                                        if (_compareDate(date, activateDate)) {
                                          isDeactivated = false;
                                          break;
                                        }
                                      }
                                    }

                                    // Check if this date is the one that is currently selected
                                    // bool isSelected =
                                    // _currentDate != null ? _compareDate(date, _currentDate!) : false;
                                    // Check if this date is the one that is currently selected
                                    bool isSelected = itemSelected == x;
                                    // Return the Date Widget
                                    return DateWidget(
                                      date: date,
                                      monthTextStyle: isDeactivated
                                          ? deactivatedDayStyle
                                          : isSelected
                                              ? widget.selectedDayStyle
                                              : widget.dayTextStyle,
                                      dateTextStyle: isDeactivated
                                          ? deactivatedDateStyle
                                          : isSelected
                                              ? widget.selectedDateStyle
                                              : widget.dateTextStyle,
                                      dayTextStyle: isDeactivated
                                          ? deactivatedDayStyle
                                          : isSelected
                                              ? widget.selectedDayStyle
                                              : widget.dayTextStyle,
                                      width: widget.width,
                                      locale: widget.locale,
                                      selectionColor: isSelected
                                          ? widget.selectionColor
                                          : Colors.white,
                                      onDateSelected: (selectedDate) {
                                        // Don't notify listener if date is deactivated
                                        if (isDeactivated) return;

                                        // A date is selected
                                        // if (widget.onDateChange != null) {
                                        //   widget.onDateChange!(selectedDate);
                                        // }
                                        // if (isSelected) {
                                        //   widget.onDateChange!(selectedDate);
                                        // }

                                        setState(() {
                                          _currentDate = selectedDate;
                                        });
                                      },
                                    );
                                  })))),
                )),
          ),
        ],
      ),
    );
  }

  /// Helper function to compare two dates
  /// Returns True if both dates are the same
  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}

class DatePickerController {
  _DatePickerState? _datePickerState;

  void setDatePickerState(_DatePickerState state) {
    _datePickerState = state;
  }

  void jumpToSelection() {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // jump to the current Date
    _datePickerState!._controller
        .jumpTo(_calculateDateOffset(_datePickerState!._currentDate!));
  }

  /// This function will animate the Timeline to the currently selected Date
  void animateToSelection(
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // animate to the current date
    _datePickerState!._controller.animateTo(
        _calculateDateOffset(_datePickerState!._currentDate!),
        duration: duration,
        curve: curve);
  }

  /// This function will animate to any date that is passed as a parameter
  /// In case a date is out of range nothing will happen
  void animateToDate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);
  }

  /// Calculate the number of pixels that needs to be scrolled to go to the
  /// date provided in the argument
  double _calculateDateOffset(DateTime date) {
    final startDate = DateTime(
        _datePickerState!.widget.startDate.year,
        _datePickerState!.widget.startDate.month,
        _datePickerState!.widget.startDate.day);

    int offset = date.difference(startDate).inDays;
    return (offset * _datePickerState!.widget.width) + (offset * 6);
  }
}
