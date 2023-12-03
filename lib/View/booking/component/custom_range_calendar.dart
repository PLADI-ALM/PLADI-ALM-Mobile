import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../colors.dart';

typedef SetSelectedDate = void Function(DateTime date);
typedef ChangedDate = void Function(DateTime? start, DateTime? end);
typedef DidTapBookedDate = void Function(DateTime date);

class CustomRangeCalender extends StatefulWidget {
  final SetSelectedDate selectDate;
  final ChangedDate changedDate;
  final double? calendarDayHeight;
  final List<String> bookedDayList;

  const CustomRangeCalender({
    required this.selectDate,
    required this.changedDate,
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
        rangeHighlightScale : 1.0,
        rangeHighlightColor: purple,
        rangeStartDecoration : const BoxDecoration(
          color: purple,
          shape: BoxShape.circle,
        ),
        rangeEndDecoration : const BoxDecoration(
            color: purple,
            shape: BoxShape.circle,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        disabledBuilder: (context, day, focusedDay) {
          return GestureDetector(
            onTap: (){ widget.selectDate(day); },
            child: Center(child: Text(day.day.toString(), style: const TextStyle(color: Colors.grey),),),
          );
        },
        dowBuilder: (context, day) {
          return Center(child: Text(weekdays[day.weekday-1], style: weekdayStyle,),);
        },
      ),
      rangeStartDay: focusedStartDay,
      rangeEndDay: focusedEndDay,
      rangeSelectionMode: RangeSelectionMode.enforced,
      onRangeSelected: (DateTime? start, DateTime? end, DateTime focusedDay) {
        setState(() {
          /// 날짜 선택 해제하는 경우
          if (focusedDay == focusedStartDay) {
            focusedStartDay = focusedEndDay;
            focusedEndDay = null;
            widget.changedDate(focusedStartDay, focusedEndDay);
            return;
          }
          if (focusedDay == focusedEndDay) {
            focusedStartDay = focusedStartDay;
            focusedEndDay = null;
            widget.changedDate(focusedStartDay, focusedEndDay);
            return;
          }

          /// 날짜 선택하는 경우
          widget.selectDate(focusedDay);  // 하단 타임 그리드 내 예약된 시간 정보 조회를 위한 메소드 호출

          if (focusedStartDay == null) { focusedStartDay = focusedDay; }
          else if (focusedEndDay == null) { focusedEndDay = focusedDay; }
          else {
            if (focusedDay.isAfter(focusedStartDay!)) { focusedEndDay = focusedDay; }
            else { focusedStartDay = focusedDay; }
          }

          widget.changedDate(focusedStartDay, focusedEndDay);

        });
      },
      selectedDayPredicate: (DateTime day) { return isSameDay(selectedDay, day); },
      enabledDayPredicate: (DateTime day) { return isBookedDay(day); }
    );
  }

  bool isBookedDay(DateTime dateTime) {
    for (var element in widget.bookedDayList) {
      if (DateFormat('yyyy-MM-dd').format(dateTime) == element) { return false; }
    }
    return true;
  }
}
