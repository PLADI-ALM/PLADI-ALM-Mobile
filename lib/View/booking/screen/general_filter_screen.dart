import 'package:flutter/material.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';

import '../component/select_time_button.dart';
import '../component/select_date_button.dart';

class GeneralFilterScreen extends StatefulWidget {

  final String appBarTitle;

  const GeneralFilterScreen({
    required this.appBarTitle,
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
      appBar: SubAppBar(titleText: widget.appBarTitle,),
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

  /// Event Methods
  void didTapApplyButton() {
    print('didTapApplyButton');
  }
}
