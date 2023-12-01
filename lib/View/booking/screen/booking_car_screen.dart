import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Model/model/booking/resource_model.dart';
import '../../../Model/model/general_model.dart';
import '../../../Presenter/booking/car_service.dart';
import '../../colors.dart';
import '../../common/component/purple_bottom_button.dart';
import '../../common/component/sub_app_bar.dart';
import '../component/custom_range_calendar.dart';
import 'booking_success_screen.dart';

class BookingCarScreen extends StatefulWidget {
  final int carId;

  const BookingCarScreen({
    required this.carId,
    Key? key
  }) : super(key: key);

  @override
  State<BookingCarScreen> createState() => _BookingCarScreenState();
}

class _BookingCarScreenState extends State<BookingCarScreen> {

  List<String> bookedDayList = [];
  List<int> bookedTimeList = [];

  DateTime? startDate;
  DateTime? endDate;
  DateTime? selectedDate;

  int startTime = -1;
  int endTime = -1;

  bool isSettingStart = true;
  bool isLoading = false;

  TextEditingController memoController = TextEditingController();

  TextStyle titleStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  void initState() {
    super.initState();
    getBookedDateListInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SubAppBar(titleText: '장비 예약',),
      body: renderBody(),
      bottomNavigationBar: PurpleBottomButton(
        title: '예약',
        onPressed: ((startDate != null) && endDate != null) ? didTapBookingButton : null,
      ),
    );
  }

  Widget renderBody() {
    return isLoading
        ? const Center(child: CircularProgressIndicator(color: Colors.purple,))
        : ListView(
      children: [
        /// 시작일시, 종료일시 텍스트
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text('시작 일시', style: titleStyle,),
                  TextButton(
                      onPressed: didTapStartDateText,
                      child: Text((startDate == null) ? '시작일시를 선택해주세요.' : DateFormat('yyyy.MM.dd HH:mm').format(startDate!),
                        style: TextStyle(fontSize: (startDate == null) ? 13 : 16, fontWeight: FontWeight.bold, color: (startDate == null) ? const Color(0xFFC9C9C9) : Colors.black),
                      )
                  ),
                ],
              ),
              Row(
                children: [
                  Text('종료 일시', style: titleStyle,),
                  TextButton(
                      onPressed: didTapEndDateText,
                      child: Text((endDate == null) ? '종료일시를 선택해주세요.' : DateFormat('yyyy.MM.dd HH:mm').format(endDate!),
                        style: TextStyle(fontSize: (endDate == null) ? 13 : 16, fontWeight: FontWeight.bold, color: (endDate == null) ? const Color(0xFFC9C9C9) : Colors.black),
                      )
                  ),
                ],
              )
            ],
          ),
        ),
        const Divider(thickness: 1.0,),
        const SizedBox(height: 10,),

        /// 날짜 선택 캘린더
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('날짜 선택', style: titleStyle,)
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            decoration: const BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: CustomRangeCalender(
              selectDate: selectDate,
              changedDate: changedDate,
              // didTapBookedDate: showBookingInfoListDialog,
              bookedDayList: bookedDayList,
            )
        ),
        const Divider(thickness: 1.0,),

        /// 시간 선택 그리드뷰
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Text('시간 선택', style: titleStyle,),
              Flexible(child: Container()),
              SizedBox(
                  width: 22, height: 22,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: didTapResetTimeGridButton,
                    icon: const Icon(CupertinoIcons.refresh, size: 22,),
                  )
              )
            ],
          ),
        ),
        renderTimeGrid(),
        const Divider(thickness: 1.0,),

        /// 이용목적 텍스트 필드
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text('이용목적', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
        ),
        renderMemoField()
      ],
    );
  }


  Widget renderTimeGrid() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 340,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, //1 개의 행에 보여줄 item 개수
            childAspectRatio: ((MediaQuery.of(context).size.width - 80) / 4) / 36, //item 의 가로 / 세로 비율
            mainAxisSpacing: 20,
            crossAxisSpacing: 15,
          ),
          itemCount: 24,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: isBookedTime(index)
                  ? () { didTapBookedTimeItem(index); }
                  : () { didTapTimeItem(index); },
              child: Container(
                width: (MediaQuery.of(context).size.width - 80) / 4,
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(11)),
                    border: Border.all(color: getBorderColorOfTimeItem(index)),
                    color: getBackColorOfTimeItem(index)
                ),
                child: Center(
                    child: Text('${index < 10 ? '0$index' : '$index'}:00',
                      style: TextStyle(fontSize: 14, color: getTextColorOfTimeItem(index)),)
                ),
              ),
            );
          }
      ),
    );
  }

  Widget renderMemoField() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 50),
      padding: const EdgeInsets.only(left: 10,right: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // color: Colors.red,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: darkGrey.withOpacity(0.3))
      ),
      child: TextField(
        controller: memoController,
        maxLength: 100,
        cursorColor: purple,
        decoration: const InputDecoration(
          hintText: '이용목적을 입력해주세요.',
          hintStyle: TextStyle(fontSize: 13, color: Color(0xFFC9C9C9)),
          border: InputBorder.none,
        ),
      ),
    );
  }


  Widget renderPopupTitleView() {
    return  Row(
      children: [
        Flexible(child: Container()),
        const Text('예약 정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
        Flexible(child: Container()),
        SizedBox(
          width: 17, height: 17,
          child: IconButton(
              onPressed: (){Navigator.of(context).pop();},
              padding: EdgeInsets.zero,
              icon: const Icon(CupertinoIcons.xmark, size: 17, color: Colors.black,)
          ),
        )
      ],
    );
  }

  Widget renderBookingInfoForPopup(GeneralBookingDetail info) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,),
          child: Row(
            children: [
              const SizedBox(
                  width: 85,
                  child: Text('예약자명', style: TextStyle(fontSize: 14, color: Color(0xFF717171)),)
              ),
              Text(info.reservatorName, style: const TextStyle(fontSize: 14, color: Colors.black),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,),
          child: Row(
            children: [
              const SizedBox(
                  width: 85,
                  child: Text('부서', style: TextStyle(fontSize: 14, color: Color(0xFF717171)),)
              ),
              Text(info.reservatorDepartment, style: const TextStyle(fontSize: 14, color: Colors.black),),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,),
          child: Row(
            children: [
              const SizedBox(
                  width: 85,
                  child: Text('연락처', style: TextStyle(fontSize: 14, color: Color(0xFF717171)),)
              ),
              Text(info.reservatorPhone, style: const TextStyle(fontSize: 14, color: Colors.black),),
              const SizedBox(width: 5,),
              SizedBox(
                width: 15, height: 15,
                child: IconButton(
                    onPressed: () { didTapCallButton(info.reservatorPhone); },
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.phone_in_talk_outlined, color: Colors.black, size: 15,)
                ),
              )
            ],
          ),
        ),
      ],
    );
  }


  /// Helper Methods
  Color getBackColorOfTimeItem(int index) {
    if (isBookedTime(index)) { return const Color(0xFFE9E9E9); }
    else if ((startTime == index) || (endTime == index)) { return purple; }
    else { return Colors.white; }
  }

  Color getBorderColorOfTimeItem(int index) {
    if (isBookedTime(index)) { return Colors.transparent; }
    else if ((startTime == index) || (endTime == index)) { return Colors.transparent; }
    else { return const Color(0xFF939393); }
  }

  Color getTextColorOfTimeItem(int index) {
    if ((startTime == index) || (endTime == index)) { return Colors.white; }
    else { return const Color(0xFF939393); }
  }

  int getTimeWithString(String timeStr) {
    timeStr = timeStr.substring(0,2);
    if (timeStr[0] == '0') { return int.parse(timeStr[1]); }
    else { return int.parse(timeStr); }
  }

  bool isBookedTime(int index) {
    for (int time in bookedTimeList) {
      if (time == index) { return true; }
      else { continue; }
    }
    return false;
  }

  /// Event Methods
  void didTapStartDateText() {
    setState(() { isSettingStart = true; });
  }

  void didTapEndDateText() {
    setState(() { isSettingStart = false; });
  }

  void changedDate(DateTime? start, DateTime? end) {
    setState(() {
      startDate = (start == null) ? null : DateTime(start.year, start.month, start.day);
      endDate = (end == null)
          ? DateTime(start!.year, start!.month, start!.day)
          : DateTime(end.year, end.month, end.day);

      print('start -> $start');
      print('end -> $end');
    });
  }

  void changedStartDate(DateTime? time) {
    setState(() {
      startDate = (time == null) ? null : DateTime(time.year, time.month, time.day);
    });
  }

  void changedEndDate(DateTime? time) {
    setState(() {
      endDate = (time == null) ? null : DateTime(time.year, time.month, time.day);
    });
  }

  void didTapResetTimeGridButton() {
    setState(() {
      startTime = -1;
      endTime = -1;
    });
  }

  void didTapBookedTimeItem(int index) async {
    dynamic response = await CarService().getBookedDetailInfo(widget.carId, (endDate == null) ? startDate! : endDate!, index);
    if (response != null) {
      dynamic data = GeneralBookingDetailResponse.fromJson(response);
      GeneralBookingDetail info = data.data;
      showBookingInfoDialog(info);
    }
  }

  void didTapCallButton(String phoneNumStr) async {
    Uri uri = Uri.parse("tel:${phoneNumStr.replaceAll('-','')}");

    if (await canLaunchUrl(uri)) { await launchUrl(uri); }
    else { Fluttertoast.showToast(msg: '전화 앱에 연결할 수 없습니다.'); }
  }

  void didTapTimeItem(int index) {
    setState(() {
      if ((isSettingStart && (startDate == null)) || (!isSettingStart && (endDate == null))) {
        Fluttertoast.showToast(msg: '날짜를 먼저 선택해주세요!');
        return;
      } else {
        didTapResetTimeGridButton();
        if (isSettingStart) {
          startTime = index;
          startDate = DateTime(startDate!.year, startDate!.month, startDate!.day, startTime);
        } else {
          endTime = index;
          endDate = DateTime(endDate!.year, endDate!.month, endDate!.day, endTime);
        }
        isSettingStart = !isSettingStart;

      }
    });
  }

  void didTapBookingButton() async {
    setState(() { isLoading = true; });
    dynamic response = await CarService().bookCar(widget.carId, startDate!, endDate!, memoController.value.text ?? '');
    setState(() { isLoading = false; });
    if (response != null) {
      if (response.runtimeType == GeneralModel) {
        if (response.status == 200) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const BookingSuccessScreen()), (route) => false);
        }
        else { Fluttertoast.showToast(msg: response.message); }
      }
      else { Fluttertoast.showToast(msg: response); }
    } else { Fluttertoast.showToast(msg: '예약에 실패하였습니다.'); }
  }


  void showBookingInfoDialog(GeneralBookingDetail info) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
          title: renderPopupTitleView(),
          content: Container(
            height: 150,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
            child: renderBookingInfoForPopup(info),
          ),
        );
      }),
    );
  }

  void showBookingInfoListDialog(List<GeneralBookingDetail> infoList) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
          title: renderPopupTitleView(),
          content: Container(
            height: 160.0 * infoList.length,
            width: MediaQuery.of(context).size.width - 100,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: infoList.length,
              itemBuilder: (BuildContext context, int index) {
                return renderBookingInfoForPopup(infoList[index]);
              },
            ),
          ),
        );
      }),
    );
  }

  bool isDisabledDay(DateTime dateTime) {
    for (var element in bookedDayList) {
      if (DateFormat('yyyy-MM-dd').format(dateTime) == element) { return true; }
    }
    return false;
  }

  /// Helper Methods
  void selectDate(DateTime dateTime) async {
    bookedTimeList = [];
    if (isDisabledDay(dateTime)) {
      dynamic response = await CarService().getBookedInfoList(widget.carId, selectedDate ?? DateTime.now());
      if (response != null) {
        dynamic data = GeneralBookingInfoListResponse.fromJson(response);
        List<GeneralBookingDetail> infoList = data.data;
        showBookingInfoListDialog(infoList);
      }

    } else {
      dynamic response = await CarService().getBookedTimeList(widget.carId, dateTime);
      if (response != null) {
        dynamic data = ResourceBookingOfDateResponse.fromJson(response);
        setBookedTimeList(data);
      }
    }
  }

  void setBookedTimeList(ResourceBookingOfDateResponse data) {
    if (data.status == 200 && data.data.isNotEmpty) {
      for (var time in data.data) {
        setState(() {
          String hourStr = time!.substring(0,2);
          bookedTimeList.add(int.parse(hourStr));
        });
      }
    }
  }

  void getBookedDateListInfo() async {
    dynamic response = await CarService().getBookedDateList(widget.carId, DateTime.now(), null);
    if (response != null) {
      ResourceBookedList data = ResourceBookedList.fromJson(response);
      setState(() { bookedDayList = data.data; });
    }
  }
}
