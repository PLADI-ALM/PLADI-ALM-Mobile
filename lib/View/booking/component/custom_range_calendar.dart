import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../colors.dart';

typedef SetSelectedDateRange = void Function(DateTime start, DateTime end);
typedef SetSelectedDate = void Function(DateTime date);

class CustomRangeCalender extends StatefulWidget {
  final SetSelectedDateRange changedDateRange;
  final SetSelectedDate changedDate;
  final double? calendarDayHeight;

  const CustomRangeCalender({
    required this.changedDateRange,
    required this.changedDate,
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
  // DateTime focusedEndDay = DateTime.now();

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
          // widget.changedDate(focusedDay);
        });
      },
      rangeStartDay: focusedStartDay,
      rangeEndDay: focusedEndDay,
      rangeSelectionMode: RangeSelectionMode.enforced,
      onRangeSelected: (DateTime? start, DateTime? end, DateTime focusedDay) {
        setState(() {
          if (focusedStartDay == null) {
            focusedStartDay = focusedDay;
            focusedEndDay = focusedDay;
          }
          else {
            focusedEndDay = focusedDay;
          }
          widget.changedDate(focusedDay);
        });
        // print('start - $start');
        // print('end - $end');
        // print('focusedDay - $focusedDay');
      },
      selectedDayPredicate: (DateTime day) {
        return isSameDay(selectedDay, day);
      },
    );
  }
}
