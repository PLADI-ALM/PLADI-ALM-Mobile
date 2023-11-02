import 'package:flutter/material.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';
import 'package:flutter/cupertino.dart';

import '../component/select_time_button.dart';

class OfficeFilterScreen extends StatefulWidget {
  const OfficeFilterScreen({Key? key}) : super(key: key);

  @override
  State<OfficeFilterScreen> createState() => _OfficeFilterScreenState();
}

class _OfficeFilterScreenState extends State<OfficeFilterScreen> {

  bool isShowTimePicker = false;

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
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18,),
          Text('날짜 선택', style: titleStyle,),
          renderCalendarView(),

          Text('시작 시간 선택', style: titleStyle,),
          SelectTimeButton(
            title: '시작 시간을 선택해주세요.',
            onPressed: didTapStartButton,
          ),
          const SizedBox(height: 15,),

          Text('종료 시간 선택', style: titleStyle,),
          SelectTimeButton(onPressed: didTapEndButton, title: '종료 시간을 선택해주세요.',),
        ],
      ),
    );
  }

  Widget renderCalendarView() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 259,
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    );
  }


  void showTimePicker() {
    TextStyle style = const TextStyle(fontSize: 13, color: Colors.black);

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
                  print('time - $time');
                },
              )
            ),
          );
        }
    );
  }

  void didTapStartButton() {
    showTimePicker();
  }

  void didTapEndButton() {
    showTimePicker();
  }

  void didTapApplyButton() {
    print('didTapApplyButton');
    Navigator.of(context).pop();
  }
}
