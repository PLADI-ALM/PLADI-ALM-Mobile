import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/Model/network/api_manager.dart';
import 'package:frontend/Presenter/booking/car_service.dart';
import 'package:frontend/View/booking/component/admin_right_item.dart';
import 'package:frontend/View/booking/screen/admin_booking_hisorty_screen.dart';
import 'package:frontend/View/booking/screen/booking_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Model/model/booking/car_model.dart';
import '../../../Model/model/booking/resource_model.dart';
import '../../../Presenter/booking/resource_service.dart';
import '../../colors.dart';
import '../../common/component/purple_bottom_button.dart';
import '../../common/component/sub_app_bar.dart';
import 'booking_resource_screen.dart';

class GeneralDetailScreen extends StatefulWidget {
  final BookingType type;
  final int id;

  const GeneralDetailScreen({required this.type, required this.id, Key? key})
      : super(key: key);

  @override
  State<GeneralDetailScreen> createState() => _GeneralDetailScreenState();
}

class _GeneralDetailScreenState extends State<GeneralDetailScreen> {
  TextStyle nameStyle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

  TextStyle manufacturerStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black);

  bool isLoading = true;
  dynamic data;

  Future<dynamic> fetchData() async {
    isLoading = true;
    dynamic response;
    switch (widget.type) {
      case BookingType.resource:
        response = await ResourceService().getResourceDetailData(widget.id);
      case BookingType.car:
        response = await CarService().getCarDetailData(widget.id);
      default:
        return;
    }
    // dynamic response = await ResourceService().getResourceDetailData(widget.resourceId);
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

  void configure(dynamic snapshotData) {
    switch (widget.type) {
      case BookingType.resource:
        data = ResourceDetailResponse.fromJson(snapshotData);
      case BookingType.car:
        data = CarDetailResponse.fromJson(snapshotData);
      default:
        return;
    }
  }

  Widget renderBody() {
    return FutureBuilder<dynamic>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
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
            }
            // data = ResourceDetailResponse.fromJson(snapshot.data);
            configure(snapshot.data);
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 800,
              child: ListView(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 232,
                    child: (data.data.imgUrl == null)
                        ? SvgPicture.asset('asset/image/main_logo.svg')
                        : Image.network(
                            data.data.imgUrl,
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            data.data.name ?? "이름",
                            style: nameStyle,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            data.data.manufacturer ?? "",
                            style: manufacturerStyle,
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        infoCardItem(Icons.location_on_outlined, '위치',
                            data.data.location ?? "위치", null),
                        const SizedBox(
                          width: 20,
                        ),
                        infoCardItem(
                            Icons.phone_in_talk_outlined,
                            '책임자',
                            data.data.responsibilityName ?? "책임자",
                            didTapPhoneItem),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      '상세정보',
                      style: nameStyle,
                    ),
                  ),
                  renderDescription(),
                ],
              ),
            );
          }
        });
  }

  Widget infoCardItem(
      IconData iconData, String info, String content, VoidCallback? onTap) {
    TextStyle infoStyle = const TextStyle(fontSize: 12, color: darkGrey);
    TextStyle contentStyle = const TextStyle(fontSize: 15, color: Colors.black);

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                data.data.description ?? "설명",
                maxLines: 30,
                style: contentStyle,
              ))
        ],
      ),
    );
  }

  /// Event Methods
  void didTapPhoneItem() async {
    Uri uri =
        Uri.parse("tel:${data.data.responsibilityPhone.replaceAll('-', '')}");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Fluttertoast.showToast(msg: '전화 앱에 연결할 수 없습니다.');
    }
  }

  void didTapBookingButton() {
    if (data == null) {
      Fluttertoast.showToast(msg: '장비 정보를 불러올 수 없으므로 예약이 불가능합니다.');
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => BookingResourceScreen(
                resourceId: widget.id,
              )));
    }
  }

  void moveToOfficeHistory() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => AdminBookingHistoryScreen(
              id: widget.id,
              currentType: widget.type,
            )));
  }
}
