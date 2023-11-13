import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../colors.dart';

typedef SetSelectedStartDate = void Function(DateTime? date);
typedef SetSelectedEndDate = void Function(DateTime? date);

class CustomRangeCalender extends StatefulWidget {
  final SetSelectedStartDate changedStartDate;
  final SetSelectedEndDate changedEndDate;
  final double? calendarDayHeight;
  final List<String> bookedDayList;

  const CustomRangeCalender({
    required this.changedStartDate,
    required this.changedEndDate,
    required this.bookedDayList,
    this.calendarDayHeight,
    Key? key
  }) : super(key: key);

  @override
  State<CustomRangeCalender> createState() => _CustomRangeCalenderState();
}

class _CustomRangeCalenderState extends State<CustomRangeCalender> {

  static const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();
  DateTime? focusedStartDay;
  DateTime? focusedEndDay;

  TextStyle weekdayStyle = const TextStyle(fontSize: 11, color: purple);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: widget.calendarDayHeight ?? 35,
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      daysOfWeekHeight: 30,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronVisible: true,
        rightChevronVisible: true,
        leftChevronMargin: EdgeInsets.only(left: 23),
        rightChevronMargin: EdgeInsets.only(right: 23),
        leftChevronIcon: Icon(Icons.chevron_left, color: purple,),
        rightChevronIcon: Icon(Icons.chevron_right, color: purple,),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        selectedDecoration: BoxDecoration(
          color: purple.withOpacity(0.6),
        ),
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          return Center(child: Text(weekdays[day.weekday-1], style: weekdayStyle,),);
        },
      ),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        setState(() {
          focusedDay = selectedDay;
        });
      },
      rangeStartDay: focusedStartDay,
      rangeEndDay: focusedEndDay,
      rangeSelectionMode: RangeSelectionMode.enforced,
      onRangeSelected: (DateTime? start, DateTime? end, DateTime focusedDay) {
        setState(() {
          if (focusedStartDay == null) {
            focusedStartDay = focusedDay;
            widget.changedStartDate(focusedDay);
          } else if (focusedEndDay == null) {
            focusedEndDay = focusedDay;
            widget.changedEndDate(focusedDay);
          } else {
            focusedStartDay = focusedDay;
            focusedEndDay = null;
            widget.changedStartDate(focusedDay);
            widget.changedEndDate(null);
          }
        });
      },
      selectedDayPredicate: (DateTime day) { return isSameDay(selectedDay, day); },
      enabledDayPredicate: (DateTime day) { return isBookedDay(day); },
    );
  }

  bool isBookedDay(DateTime dateTime) {
    for (var element in widget.bookedDayList) {
      if (DateFormat('yyyy-MM-dd').format(dateTime) == element) { return false; }
    }
    return true;
  }
}
