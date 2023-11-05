import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/Presenter/booking/resource_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../Model/model/booking/resource_model.dart';
import '../../colors.dart';
import '../../common/component/purple_bottom_button.dart';
import '../../common/component/sub_app_bar.dart';

class ResourceDetailScreen extends StatefulWidget {

  final int resourceId;

  const ResourceDetailScreen({
    required this.resourceId,
    Key? key
  }) : super(key: key);

  @override
  State<ResourceDetailScreen> createState() => _ResourceDetailScreenState();
}

class _ResourceDetailScreenState extends State<ResourceDetailScreen> {

  TextStyle nameStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

  bool isLoading = true;
  dynamic data;

  Future<dynamic> fetchData() async {
    isLoading = true;
    dynamic response = await ResourceService().getResourceDetailData(widget.resourceId);
    isLoading = false;
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SubAppBar(titleText: '',),
      body: renderBody(),
      bottomNavigationBar: PurpleBottomButton(title: '예약', onPressed: didTapBookingButton,),
    );
  }

  Widget renderBody() {
    return FutureBuilder<dynamic>(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError || snapshot.data == null) {
          return const Center(
            child: Text('정보를 불러오지 못 하였습니다.',
              style: TextStyle(fontSize: 16, color: purple),),
          );
        }
        else {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator(color: purple,),);
          }
          data = ResourceDetailResponse.fromJson(snapshot.data);
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 800,
            child: ListView(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 232,
                  child: (data.data.imgUrl == null)
                    ? const Center(child: Text('이미지를 불러올 수 없습니다.', style: TextStyle(fontSize: 16, color: purple),),)
                    : Image.network(data.data.imgUrl, fit: BoxFit.fitWidth,),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(data.data.name, style: nameStyle,),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      infoCardItem(Icons.location_on_outlined, '위치', data.data.location, null),
                      const SizedBox(width: 20,),
                      infoCardItem(Icons.phone_in_talk_outlined, '책임자', data.data.responsibilityName, didTapPhoneItem),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('상세정보', style: nameStyle,),
                ),

                renderDescription(),
              ],
            ),
          );
        }
      }
    );
  }

  Widget infoCardItem(IconData iconData, String info, String content, VoidCallback? onTap) {
    TextStyle infoStyle = const TextStyle(fontSize: 12, color: darkGrey);
    TextStyle contentStyle = const TextStyle(fontSize: 15, color: Colors.black);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(context).size.width - 60) / 2,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: const Color(0xFF939393))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10,),
            Container(
              width: 34, height: 34,
              decoration: const BoxDecoration(
                  color: Color(0xFFF3ECFB),
                  borderRadius: BorderRadius.all(Radius.circular(17))
              ),
              child: Icon(iconData, color: Colors.black, size: 24,),
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(info, style: infoStyle,),
                Text(content, style: contentStyle,),
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
          const Text('설명', style: TextStyle(fontSize: 14, color: darkGrey),),
          const SizedBox(width: 30,),
          SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(data.data.description, maxLines: 30, style: contentStyle,)
          )
        ],
      ),
    );
  }

  /// Event Methods
  void didTapPhoneItem() async {
    Uri uri = Uri.parse("tel:${data.data.responsibilityPhone.replaceAll('-','')}");

    if (await canLaunchUrl(uri)) { await launchUrl(uri); }
    else { Fluttertoast.showToast(msg: '전화 앱에 연결할 수 없습니다.'); }
  }
  
  void didTapBookingButton() {
    if (data == null) {
      Fluttertoast.showToast(msg: '회의실 정보를 불러올 수 없으므로 예약이 불가능합니다.');
    } else {
      // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BookingResourceScreen()));
    }
  }
}
