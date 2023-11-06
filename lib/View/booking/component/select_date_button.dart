import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../colors.dart';

typedef SetSelectedDate = void Function(DateTime date);

class SelectDateButton extends StatefulWidget {
  final String hintText;
  final String bottomSheetTopTitle;
  final SetSelectedDate changedDate;
  final double? calendarDayHeight;

  const SelectDateButton({
    required this.hintText,
    required this.bottomSheetTopTitle,
    required this.changedDate,
    this.calendarDayHeight,
    Key? key
  }) : super(key: key);

  @override
  State<SelectDateButton> createState() => _SelectDateButtonState();
}

class _SelectDateButtonState extends State<SelectDateButton> {

  static const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();

  String hintText = '';

  @override
  void initState() {
    super.initState();
    hintText = widget.hintText;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 13, color: (selectedDay != null) ? Colors.black : const Color(0xFFC9C9C9));

    return Container(
      height: 42,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: const Color(0xFF939393))
      ),
      child: TextButton(
          onPressed: showBottomCalendar,
          child: Row(
            children: [
              Text(hintText, style: style,),
              Flexible(child: Container()),
              const Icon(Icons.calendar_today_outlined, size: 24, color: Colors.black,)
            ],
          )
      ),
    );
  }

  void showBottomCalendar() {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext buildContext) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.63,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: Row(
                          children: [
                            const SizedBox(width: 15,),
                            Text(widget.bottomSheetTopTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                            Flexible(child: Container()),
                            IconButton(
                                onPressed: (){Navigator.of(context).pop();},
                                icon: const Icon(CupertinoIcons.xmark, color: Colors.black, size: 24,)
                            )
                          ],
                        ),
                      ),

                      renderCalendarView(),
                    ],
                  ),
              ),
            ),
          );
        }
    );
  }

  Widget renderCalendarView() {
    TextStyle weekdayStyle = const TextStyle(fontSize: 11, color: purple);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: TableCalendar(
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
            hintText = DateFormat('yyyy-MM-dd').format(this.selectedDay!);
          });
        },
        selectedDayPredicate: (DateTime day) {
          return isSameDay(selectedDay, day);
        },
      ),
    );
  }
}
