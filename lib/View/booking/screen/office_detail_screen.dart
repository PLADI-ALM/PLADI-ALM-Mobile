import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/Model/model/booking/office_model.dart';
import 'package:frontend/Model/network/api_manager.dart';
import 'package:frontend/Presenter/booking/office_service.dart';
import 'package:frontend/View/booking/component/admin_right_item.dart';
import 'package:frontend/View/booking/screen/admin_booking_hisorty_screen.dart';
import 'package:frontend/View/booking/screen/booking_office_screen.dart';
import 'package:frontend/View/booking/screen/booking_screen.dart';
import 'package:frontend/View/colors.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';

class OfficeDetailScreen extends StatefulWidget {
  final int officeId;

  const OfficeDetailScreen({required this.officeId, Key? key})
      : super(key: key);

  @override
  State<OfficeDetailScreen> createState() => _OfficeDetailScreenState();
}

class _OfficeDetailScreenState extends State<OfficeDetailScreen> {
  bool isLoading = true;
  dynamic data;

  Future<dynamic> fetchData() async {
    isLoading = true;
    dynamic response = await OfficeService().getOfficeInfoData(widget.officeId);
    isLoading = false;
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubAppBar(
        titleText: '',
        rightItems: [
          APIManager().isAdmin
              ? AdminRightButton(
                  onPressed: moveToOfficeHistory,
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                )
        ],
      ),
      body: renderBody(),
      bottomNavigationBar: PurpleBottomButton(
        title: '예약',
        onPressed: didTapBookingButton,
      ),
    );
  }

  Widget renderBody() {
    TextStyle nameStyle = const TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

    return FutureBuilder<dynamic>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
            isLoading = false;
            return const Center(
              child: Text(
                '정보를 불러오지 못 하였습니다.',
                style: TextStyle(fontSize: 16, color: purple),
              ),
            );
          } else {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: purple,
                ),
              );
            } else {
              data = OfficeDetailResponse.fromJson(snapshot.data);
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 800,
                child: ListView(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 232,
                      child: Image.network(
                        data.data.imgUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        data.data.name ?? "회의실 이름",
                        style: nameStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          infoCardItem(Icons.location_on_outlined, '위치',
                              data.data.location ?? "위치"),
                          const SizedBox(
                            width: 20,
                          ),
                          infoCardItem(CupertinoIcons.person_2, '수용인원',
                              data.data.capacity ?? "수용인원"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        '상세정보',
                        style: nameStyle,
                      ),
                    ),
                    renderFacilityListInfo(),
                    const SizedBox(
                      height: 15,
                    ),
                    renderDescription(),
                  ],
                ),
              );
            }
          }
        });
  }

  Widget infoCardItem(IconData iconData, String info, String content) {
    TextStyle infoStyle = const TextStyle(fontSize: 12, color: darkGrey);
    TextStyle contentStyle = const TextStyle(fontSize: 15, color: Colors.black);

    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 2,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: const Color(0xFF939393))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
                color: Color(0xFFF3ECFB),
                borderRadius: BorderRadius.all(Radius.circular(17))),
            child: Icon(
              iconData,
              color: Colors.black,
              size: 24,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                info,
                style: infoStyle,
              ),
              Text(
                content,
                style: contentStyle,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget renderFacilityListInfo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '시설',
            style: TextStyle(fontSize: 14, color: darkGrey),
          ),
          const SizedBox(
            width: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            height: 30.0 * (data.data.facilityList.length / 2),
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                  childAspectRatio:
                      ((MediaQuery.of(context).size.width - 100) / 2) /
                          20, //item 의 가로 / 세로 비율
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 0,
                ),
                itemCount: data.data.facilityList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                      width: (MediaQuery.of(context).size.width - 100) / 2,
                      height: 20,
                      child: Text(
                        data.data.facilityList[index],
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ));
                }),
          ),
        ],
      ),
    );
  }

  Widget renderDescription() {
    TextStyle contentStyle = const TextStyle(fontSize: 14, color: Colors.black);

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '설명',
            style: TextStyle(fontSize: 14, color: darkGrey),
          ),
          const SizedBox(
            width: 30,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                data.data.description,
                maxLines: 30,
                style: contentStyle,
              ))
        ],
      ),
    );
  }

  /// Event Methods
  void didTapBookingButton() {
    if (data == null) {
      Fluttertoast.showToast(msg: '회의실 정보를 불러오지 못 하여 예약이 불가능합니다.');
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => BookingOfficeScreen(
                officeId: widget.officeId,
              )));
    }
  }

  void moveToOfficeHistory() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => AdminBookingHistoryScreen(
              id: widget.officeId,
              currentType: BookingType.office,
            )));
  }
}
