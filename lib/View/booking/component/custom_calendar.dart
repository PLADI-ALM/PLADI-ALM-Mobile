import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../colors.dart';

typedef SetSelectedDate = void Function(DateTime date);

class CustomCalender extends StatefulWidget {
  final SetSelectedDate changedDate;
  final double? calendarDayHeight;

  const CustomCalender({
    required this.changedDate,
    required this.calendarDayHeight,
    Key? key
  }) : super(key: key);

  @override
  State<CustomCalender> createState() => _CustomCalenderState();
}

class _CustomCalenderState extends State<CustomCalender> {

  static const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();

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
          this.selectedDay = selectedDay;
          this.focusedDay = selectedDay;
          widget.changedDate(this.selectedDay!);
          // hintText = DateFormat('yyyy-MM-dd').format(this.selectedDay!);
        });
      },
      selectedDayPredicate: (DateTime day) {
        return isSameDay(selectedDay, day);
      },
    );
  }
}
