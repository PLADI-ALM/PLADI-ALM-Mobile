import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/Presenter/booking/office_service.dart';
import 'package:frontend/View/booking/component/select_time_button.dart';
import 'package:frontend/View/colors.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


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

  @override
  void initState() {
    super.initState();

    if (OfficeService().selectedDate != null) {
      selectedDay = OfficeService().selectedDate;
      focusedDay = selectedDay!;
    }

    if (OfficeService().startTime != null) {
      startTime = OfficeService().startTime;
    }

    if (OfficeService().endTime != null) {
      endTime = OfficeService().endTime;
    }

  }

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
              initialTitle: startHintStr,
              bottomSheetTopTitle: '시작 시간 선택',
              changeTime: (DateTime time) { setState(() { startTime = time; });
            }
          ),
          const SizedBox(height: 15,),

          Text('종료 시간 선택', style: titleStyle,),
          SelectTimeButton(
              initialTitle: endHintStr,
              bottomSheetTopTitle: '종료 시간 선택',
              changeTime: (DateTime time) { setState(() { endTime = time; });
              }
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
          });
        },
        selectedDayPredicate: (DateTime day) {
          return isSameDay(selectedDay, day);
        },
      ),
    );
  }

  String getTrimmedTimeStr(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  void didTapApplyButton() {
    if ((selectedDay == null) || (startTime == null) || (endTime == null)) {
      Fluttertoast.showToast(msg: '날짜와 시작, 종료 시간을 모두 선택해주세요!', gravity: ToastGravity.BOTTOM);
    } else {
      if(endTime!.isAfter(startTime!) && !(endTime!.isAtSameMomentAs(startTime!))) {
        OfficeService().setDate(selectedDay!);
        OfficeService().setStartTime(startTime!);
        OfficeService().setEndTime(endTime!);

        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(msg: '종료 시간은 시작 시간보다 이후이어야 합니다.');
      }
    }
  }
}
