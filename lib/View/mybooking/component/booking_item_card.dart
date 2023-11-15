import 'package:flutter/material.dart';

import '../../colors.dart';
import 'booking_status_item.dart';

class BookingItemCard extends StatefulWidget {
  const BookingItemCard({Key? key}) : super(key: key);

  @override
  State<BookingItemCard> createState() => _BookingItemCardState();
}

class _BookingItemCardState extends State<BookingItemCard> {

  TextStyle nameStyle = const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle locationStyle = const TextStyle(fontSize: 12, color: Color(0xFF959595));

  TextStyle titleStyle = const TextStyle(fontSize: 12, color: Color(0xFF959595));
  TextStyle contentStyle = const TextStyle(fontSize: 12, color: Color(0xFF1B2128));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: const Color(0xFFC9C9C9))
      ),
      child: Column(
        children: [
          /// 이름, 위치, 더보기 버튼
          Row(
            children: [
              const SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5,),
                  Text('회의실1', style: nameStyle,),
                  const SizedBox(height: 2,),
                  Text('401호', style: locationStyle,)
                ],
              ),
              Expanded(child: Container()),
              SizedBox(
                child: IconButton(
                    style: IconButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: didTapDetailButton, icon: Icon(Icons.arrow_forward_ios, size: 16,)),
              )
            ],
          ),
          const Divider(thickness: 1.2,),

          /// 예약일시, 이용목적, 예약상태
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('예약일시', style: titleStyle,),
                ),
                Text('2023.11.01 17:00 ~ 2023.11.10 01:00', style: contentStyle, overflow: TextOverflow.ellipsis)
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('이용목적', style: titleStyle,),
                ),
                Expanded(child: Text('이용목적입니다. 이용목적입니다. 이용목적입니다. 이용목적입니다. 이용목적입니다. 이용목적입니다. ', style: contentStyle, textAlign: TextAlign.justify,))
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('예약상태', style: titleStyle,),
                ),
                Expanded(child: Container()),
                BookingStatusItem(status: '예약중'),
              ],
            ),
          ),

          /// 취소, 반납 버튼
          renderCancelButton('예약중')
        ],
      ),
    );
  }

  Widget renderCancelButton(String bookingStatus) {
    TextStyle buttonStyle = const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: purple);
    if (bookingStatus == '예약중' || bookingStatus == '예약대기') {
      return Row(
        children: [
          Expanded(child: Container()),
          TextButton(onPressed: didTapCancelButton, child: Text('취소', style: buttonStyle,))
        ],
      );
    } else {
      return const SizedBox(height: 0,);
    }
  }

  /// Event Methods
  void didTapDetailButton() {
    print('didTapDetailButton');
  }

  void didTapCancelButton() {
    print('didTapCancelButton');
  }
}
