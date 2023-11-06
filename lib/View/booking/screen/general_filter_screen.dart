import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/Presenter/booking/car_service.dart';
import 'package:frontend/Presenter/booking/resource_service.dart';
import 'package:frontend/View/booking/screen/booking_screen.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';

import '../component/select_time_button.dart';
import '../component/select_date_button.dart';

class GeneralFilterScreen extends StatefulWidget {

  final BookingType type;

  const GeneralFilterScreen({
    required this.type,
    Key? key
  }) : super(key: key);

  @override
  State<GeneralFilterScreen> createState() => _GeneralFilterScreenState();
}

class _GeneralFilterScreenState extends State<GeneralFilterScreen> {

  DateTime? startDate;
  DateTime? endDate;

  DateTime? startTime;
  DateTime? endTime;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubAppBar(titleText: getAppBarTitle(),),
      body: renderBody(),
      bottomNavigationBar: PurpleBottomButton(title: '적용', onPressed: didTapApplyButton,),
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
          Text('시작 일시 선택', style: titleStyle,),
          SelectDateButton(
            hintText: '시작 날짜를 선택해주세요',
            bottomSheetTopTitle: '시작 날짜 선택',
            changedDate: (DateTime date) { setState(() { startDate = date; }); },
            calendarDayHeight: 50
          ),
          SelectTimeButton(
            initialTitle: '시작 시간을 선택해주세요',
            bottomSheetTopTitle: '시작 시간 선택',
            changeTime: (DateTime time) { setState(() { startTime = time; }); },
          ),
          const SizedBox(height: 10,),
          const Divider(thickness: 1.0,),

          const SizedBox(height: 18,),
          Text('종료 일시 선택', style: titleStyle,),
          SelectDateButton(
            hintText: '종료 날짜를 선택해주세요',
            bottomSheetTopTitle: '종료 날짜 선택',
            changedDate: (DateTime date) { setState(() { endDate = date; }); },
            calendarDayHeight: 50
          ),
          SelectTimeButton(
            initialTitle: '종료 시간을 선택해주세요',
            bottomSheetTopTitle: '종료 시간 선택',
            changeTime: (DateTime time) { setState(() { endTime = time; }); },
          ),

          const SizedBox(height: 10,),
          const Divider(thickness: 1.0,),
        ]
      )
    );
  }

  String getAppBarTitle() {
    switch (widget.type) {
      case BookingType.office: return '';
      case BookingType.resource: return '사용 가능 장비 검색';
      case BookingType.car: return '사용 가능 차량 검색';
    }
  }

  /// Event Methods
  void didTapApplyButton() {
    if ((startDate == null) || (endDate == null) || (startTime == null) || (endTime == null)) {
      Fluttertoast.showToast(msg: '날짜와 시작, 종료 시간을 모두 선택해주세요!', gravity: ToastGravity.BOTTOM);
    } else {
      if(endDate!.isAfter(startDate!)) {
        if (widget.type == BookingType.resource) {
          ResourceService().setStartInfo(startDate!, startTime!);
          ResourceService().setEndInfo(endDate!, endTime!);
        } else {
          CarService().setStartInfo(startDate!, startTime!);
          CarService().setEndInfo(endDate!, endTime!);
        }

        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(msg: '종료 시간은 시작 시간보다 이후이어야 합니다.');
      }
    }
  }
}
