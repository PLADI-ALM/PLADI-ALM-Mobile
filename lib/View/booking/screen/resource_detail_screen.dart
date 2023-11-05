import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../common/component/purple_bottom_button.dart';
import '../../common/component/sub_app_bar.dart';

class ResourceDetailScreen extends StatefulWidget {
  const ResourceDetailScreen({Key? key}) : super(key: key);

  @override
  State<ResourceDetailScreen> createState() => _ResourceDetailScreenState();
}

class _ResourceDetailScreenState extends State<ResourceDetailScreen> {

  TextStyle nameStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 800,
      child: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 232,
            // child: Image.network(data.data.imgUrl, fit: BoxFit.fitWidth,),
            color: Colors.grey,
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('장비명', style: nameStyle,),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                infoCardItem(Icons.location_on_outlined, '위치', 'S1350'),
                const SizedBox(width: 20,),
                infoCardItem(Icons.phone_in_talk_outlined, '책임자', '홍길동'),
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

  Widget infoCardItem(IconData iconData, String info, String content) {
    TextStyle infoStyle = const TextStyle(fontSize: 12, color: darkGrey);
    TextStyle contentStyle = const TextStyle(fontSize: 15, color: Colors.black);

    return Container(
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
              child: Text('설명입니다 설명입니다 설명입니다 설명입니다 설명입니다 설명입니다 설명입니다 설명입니다', maxLines: 30, style: contentStyle,)
          )
        ],
      ),
    );
  }

  /// Event Methods
  void didTapBookingButton() {
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BookingOfficeScreen()));
  }
}
