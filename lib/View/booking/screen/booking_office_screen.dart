import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/Model/model/booking/office_model.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:frontend/View/booking/component/custom_calendar.dart';
import 'package:frontend/View/colors.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Presenter/booking/office_service.dart';
import '../../common/component/purple_bottom_button.dart';
import 'booking_success_screen.dart';

class BookingOfficeScreen extends StatefulWidget {
  final int officeId;

  const BookingOfficeScreen({
    required this.officeId,
    Key? key
  }) : super(key: key);

  @override
  State<BookingOfficeScreen> createState() => _BookingOfficeScreenState();
}

class _BookingOfficeScreenState extends State<BookingOfficeScreen> {

  DateTime? selectedDay;

  int startTime = -1;
  int endTime = -1;
  List<List<int>> bookedTimeList = [];

  TextEditingController memoController = TextEditingController();

  bool isLoading = true;
  dynamic data;

  Future<dynamic> fetchData() async {
    bookedTimeList = [];
    isLoading = true;
    dynamic response = await OfficeService().getBookedTimeList(widget.officeId, selectedDay ?? DateTime.now());
    if (response != null) {
      data = OfficeBookingResponse.fromJson(response);
      setBookedTimeList(data);
    }
    isLoading = false;
    return response;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SubAppBar(titleText: '회의실 예약',),
      body: renderBody(),
      bottomNavigationBar: PurpleBottomButton(
        title: '예약',
        onPressed: ((selectedDay != null) && ((endTime - startTime) > 0)) ? didTapBookingButton : null,
      ),
    );
  }

  Widget renderBody() {
    return GestureDetector(
      onTap: () { FocusScope.of(context).unfocus(); },
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text('날짜 선택', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
          ),

          renderCalendar(),
          const Divider(thickness: 1.0,),

          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('시간 선택', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
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
              )
          ),
          const SizedBox(height: 15,),

          renderTimeGrid(),
          const Divider(thickness: 1.0,),

          const Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text('이용목적', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
          ),
          renderMemoField()
        ],
      ),
    );
  }

  Widget renderCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: CustomCalender(
        calendarDayHeight: 35,
        changedDate: (DateTime date) {
          setState(() {
            selectedDay = date;
            startTime = -1;
            endTime = -1;
            fetchData();
          });
        },
      ),
    );
  }

  Widget renderTimeGrid() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 340,
      margin: const EdgeInsets.symmetric(horizontal: 20),
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

  void showBookingInfoDialog(BookingDetail info) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Row(
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
          ),
          content: Container(
            height: 150,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
            child: Column(
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
            ),
          ),
        );
      }),
    );
  }

  Color getBackColorOfTimeItem(int index) {
    if (isBookedTime(index)) { return const Color(0xFFE9E9E9); }
    else if (isContainInSelectedTime(index)) { return purple; }
    else { return Colors.white; }
  }

  Color getBorderColorOfTimeItem(int index) {
    if (isBookedTime(index)) { return Colors.transparent; }
    else if (isContainInSelectedTime(index)) { return Colors.transparent; }
    else { return const Color(0xFF939393); }
  }

  Color getTextColorOfTimeItem(int index) {
    if (isContainInSelectedTime(index)) { return Colors.white; }
    else { return const Color(0xFF939393); }
  }


  /// Helper Methods
  void setBookedTimeList(OfficeBookingResponse data) {
    if (data.status == 200 && data.data.bookedTimes.isNotEmpty) {
      for (var time in data.data.bookedTimes) {
        setState(() {
          bookedTimeList.add([getTimeWithString(time!.startTime), getTimeWithString(time!.endTime)]);
        });
      }
    }
  }

  int getTimeWithString(String timeStr) {
    timeStr = timeStr.substring(0,2);
    if (timeStr[0] == '0') { return int.parse(timeStr[1]); }
    else { return int.parse(timeStr); }
  }

  bool isBookedTime(int index) {
    for (List<int> time in bookedTimeList) {
      if ((time[0] <= index) && (time[1] > index)) { return true; }
      else { continue; }
    }
    return false;
  }

  bool isContainInSelectedTime(int index) {
    return ((startTime <= index) && (endTime >= index));
  }

  /// Event Methods
  void didTapResetTimeGridButton() {
    setState(() {
      startTime = -1;
      endTime = -1;
    });
  }

  void didTapBookedTimeItem(int index) async {
    dynamic response = await OfficeService().getBookedInfo(widget.officeId, selectedDay ?? DateTime.now(), index);
    if (response != null) {
      dynamic data = BookingDetailResponse.fromJson(response);
      BookingDetail info = data.data;
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
      if (startTime == -1 && endTime == -1) { // 시간 선택이 안 되어 있는 초기 상태인 경우
        startTime = index;
        endTime = index;
      } else {
        if (startTime <= index) { endTime = index; }
        else { startTime = index; }
      }
    });
  }

  void didTapBookingButton() async {
    dynamic response = await OfficeService().bookOffice(widget.officeId, selectedDay!, startTime, endTime, memoController.value.text ?? '');
    if (response != null) {
      if (response.runtimeType == GeneralModel) {
        if (response.status == 200) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const BookingSuccessScreen()), (route) => false);
        }
        else { Fluttertoast.showToast(msg: response.message); }
      }
      else { Fluttertoast.showToast(msg: response); }
    }
  }
}
