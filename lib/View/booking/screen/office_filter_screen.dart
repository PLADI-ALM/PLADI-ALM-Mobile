import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/View/colors.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../component/select_time_button.dart';

class OfficeFilterScreen extends StatefulWidget {
  const OfficeFilterScreen({Key? key}) : super(key: key);

  @override
  State<OfficeFilterScreen> createState() => _OfficeFilterScreenState();
}

class _OfficeFilterScreenState extends State<OfficeFilterScreen> {

  static const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const startHintStr = '시작 시간을 선택해주세요';
  static const endHintStr = '종료 시간을 선택해주세요';

  bool isShowTimePicker = false;

  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();

  DateTime? startTime;
  DateTime? endTime;

  String startTimeHintText = startHintStr;
  String endTimeHintText = endHintStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SubAppBar(titleText: '예약 가능한 회의실 검색',),
      body: renderBody(),
      bottomNavigationBar: PurpleBottomButton(title: '적용', onPressed: didTapApplyButton ,),
    );
  }

  Widget renderBody() {
    TextStyle titleStyle = const TextStyle(fontSize: 16, color: Colors.black);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18,),
          Text('날짜 선택', style: titleStyle,),
          renderCalendarView(),

          Text('시작 시간 선택', style: titleStyle,),
          SelectTimeButton(
            title: startTimeHintText,
            onPressed: (){ showTimePicker(true); },
            isContentInit: (startTimeHintText != startHintStr),
          ),
          const SizedBox(height: 15,),

          Text('종료 시간 선택', style: titleStyle,),
          SelectTimeButton(
            onPressed: (){ showTimePicker(false); },
            title: endTimeHintText,
            isContentInit: (endTimeHintText != endHintStr),
          ),
        ],
      ),
    );
  }

  Widget renderCalendarView() {
    TextStyle weekdayStyle = const TextStyle(fontSize: 11, color: purple);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: TableCalendar(
        rowHeight: 35,
        focusedDay: focusedDay,
        firstDay: DateTime(2023,1,1),
        lastDay: DateTime(2023,12,31),
        // locale: 'ko-KR',
        daysOfWeekHeight: 30,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          // titleTextFormatter: (date, locale) => ,
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
          });
        },
        selectedDayPredicate: (DateTime day) {
          return isSameDay(selectedDay, day);
        },
      ),
    );
  }


  void showTimePicker(bool isStart) {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext buildContext) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 285,
              color: Colors.white,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (DateTime time) {
                  setState(() {
                    if(isStart) {
                      startTime = time;
                      startTimeHintText = getTrimmedTimeStr(time);
                    }
                    else {
                      endTime = time;
                      endTimeHintText = getTrimmedTimeStr(time);
                    }
                  });
                },
              )
            ),
          );
        }
    );
  }

  String getTrimmedTimeStr(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  void didTapApplyButton() {
    if ((selectedDay == null) || (startTimeHintText == startHintStr) || (endTimeHintText == endHintStr)) {
      Fluttertoast.showToast(msg: '날짜와 시작, 종료 시간을 모두 선택해주세요!', gravity: ToastGravity.BOTTOM);
    } else {
      if(endTime!.isAfter(startTime!) && !(endTime!.isAtSameMomentAs(startTime!))) {
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(msg: '종료 시간은 시작 시간보다 이후이어야 합니다.');
      }
    }
  }
}
