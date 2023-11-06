import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'custom_calendar.dart';

class SelectDateButton extends StatefulWidget {
  final String hintText;
  final String bottomSheetTopTitle;
  final SetSelectedDate changedDate;

  const SelectDateButton({
    required this.hintText,
    required this.bottomSheetTopTitle,
    required this.changedDate,
    Key? key
  }) : super(key: key);

  @override
  State<SelectDateButton> createState() => _SelectDateButtonState();
}

class _SelectDateButtonState extends State<SelectDateButton> {

  DateTime? selectedDay;
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: CustomCalender(
        changedDate: (DateTime date) {
          selectedDay = date;
          hintText = DateFormat('yyyy-MM-dd').format(selectedDay!);
          widget.changedDate(date);
        },
        calendarDayHeight: 50,
      ),
    );
  }
}
