import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/Presenter/booking/office_service.dart';
import 'package:frontend/View/booking/component/custom_calendar.dart';
import 'package:frontend/View/booking/component/select_time_button.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';
import 'package:intl/intl.dart';


class OfficeFilterScreen extends StatefulWidget {
  const OfficeFilterScreen({Key? key}) : super(key: key);

  @override
  State<OfficeFilterScreen> createState() => _OfficeFilterScreenState();
}

class _OfficeFilterScreenState extends State<OfficeFilterScreen> {

  static const startHintStr = '시작 시간을 선택해주세요';
  static const endHintStr = '종료 시간을 선택해주세요';

  DateTime? selectedDay;
  DateTime? startTime;
  DateTime? endTime;

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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: CustomCalender(
        calendarDayHeight: 35,
        changedDate: (DateTime date) {
          setState(() { selectedDay = date; });
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
