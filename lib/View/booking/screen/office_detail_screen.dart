import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/View/booking/screen/booking_office_screen.dart';
import 'package:frontend/View/colors.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';

class OfficeDetailScreen extends StatefulWidget {

  final int officeId;

  const OfficeDetailScreen({
    required this.officeId,
    Key? key
  }) : super(key: key);

  @override
  State<OfficeDetailScreen> createState() => _OfficeDetailScreenState();
}

class _OfficeDetailScreenState extends State<OfficeDetailScreen> {
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
    TextStyle nameStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 800,
      child: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 232,
            color: Colors.grey,
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('회의실명', style: nameStyle,),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                infoCardItem(Icons.location_on_outlined, '위치', 'S1350'),
                const SizedBox(width: 20,),
                infoCardItem(CupertinoIcons.person_2, '수용인원', '6'),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('상세정보', style: nameStyle,),
          ),

          renderFacilityListInfo(),
          const SizedBox(height: 15,),
          renderDescription(),
        ],
      ),
    );
  }


  Widget infoCardItem(IconData iconData, String info, String content) {
    TextStyle infoStyle = const TextStyle(fontSize: 12, color: darkGrey);
    TextStyle contentStyle = const TextStyle(fontSize: 15, color: Colors.black);

    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 2,
      height: 60,
      // padding: const EdgeInsets.all(13),
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
    );
  }

  Widget renderFacilityListInfo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('시설', style: TextStyle(fontSize: 14, color: darkGrey),),
          const SizedBox(width: 30,),
          SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            height: 30.0 * (4/2),
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                  childAspectRatio: ((MediaQuery.of(context).size.width - 100) / 2) / 20, //item 의 가로 / 세로 비율
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 0,
                ),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                      width: (MediaQuery.of(context).size.width - 100) / 2,
                      height: 20,
                      child: Text('시설 이름', style: TextStyle(fontSize: 14, color: Colors.black),)
                  );
                }
            ),
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
          const Text('설명', style: TextStyle(fontSize: 14, color: darkGrey),),
          const SizedBox(width: 30,),
          SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Text('설명입니다. 설명입니다. 설명입니다. 설명입니다. 설명입니다. 설명입니다. 설명입니다. 설명입니다. ', maxLines: 30, style: contentStyle,)
          )
        ],
      ),
    );
  }

  /// Event Methods
  void didTapBookingButton() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BookingOfficeScreen()));
  }
}
