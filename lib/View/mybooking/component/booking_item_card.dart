import 'package:flutter/material.dart';
import 'package:frontend/View/booking/screen/booking_screen.dart';
import 'package:frontend/View/booking/screen/office_detail_screen.dart';

import '../../booking/screen/general_detail_screen.dart';
import '../../colors.dart';
import 'booking_status_item.dart';

class BookingItemCard extends StatefulWidget {
  final BookingType type;
  final int id;
  final String name;
  final String detailInfo;
  final String startDateTime;
  final String endDateTime;
  final String memo;
  final String status;

  const BookingItemCard({
    required this.type,
    required this.id,
    required this.name,
    required this.detailInfo,
    required this.startDateTime,
    required this.endDateTime,
    required this.memo,
    required this.status,
    Key? key
  }) : super(key: key);

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
                  Text(widget.name, style: nameStyle,),
                  const SizedBox(height: 2,),
                  Text(widget.detailInfo, style: locationStyle,)
                ],
              ),
              Expanded(child: Container()),
              SizedBox(
                child: IconButton(
                    style: IconButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: didTapDetailButton, icon: const Icon(Icons.arrow_forward_ios, size: 16,)),
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
                Text('${widget.startDateTime} ~ ${widget.endDateTime}', style: contentStyle, overflow: TextOverflow.ellipsis)
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
                Expanded(child: Text(widget.memo, style: contentStyle, textAlign: TextAlign.justify,))
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
                BookingStatusItem(status: widget.status),
              ],
            ),
          ),

          /// 취소, 반납 버튼
          renderCancelButton(widget.status)
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
          TextButton(
            child: Text('취소', style: buttonStyle,),
            onPressed: () { showCancelBookingBottomSheet(); },
          )
        ],
      );
    } else if ((widget.type == BookingType.resource) || (widget.type == BookingType.car)) {
      if ((bookingStatus == '사용중')) {
        return Row(
          children: [
            Expanded(child: Container()),
            TextButton(
              child: Text('반납', style: buttonStyle,),
              onPressed: () { print('반납 버튼 클릭함'); },
            )
          ],
        );
      } else { return const SizedBox(height: 0,); }
    } else { return const SizedBox(height: 0,); }
  }

  void showCancelBookingBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
        builder: (BuildContext context) {
          return Container(
            height: 180,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(height: 30,),
                const Text('예약을 취소하시겠습니까?', style: TextStyle(fontSize: 16, color: Color(0xFF656565)),),
                const SizedBox(height: 30,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 42,
                        width: (MediaQuery.of(context).size.width - 30)/2,
                        child: Expanded(
                          child: ElevatedButton(
                            onPressed: didTapCancelButton,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(color: Color(0xFFC9C9C9))
                              )
                            ),
                            child: const Text('취소', style: TextStyle(fontSize: 14, color: Color(0xFF717171)),),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      SizedBox(
                        height: 42,
                        width: (MediaQuery.of(context).size.width - 30)/2,
                        child: Expanded(
                          child: ElevatedButton(
                            onPressed: didTapRemoveBookingButton,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: purple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                              )
                            ),
                            child: const Text('확인', style: TextStyle(fontSize: 14, color: Colors.white),),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  /// Event Methods
  void didTapDetailButton() {
    StatefulWidget screen;
    switch(widget.type) {
      case BookingType.office: screen = OfficeDetailScreen(officeId: widget.id);
      case BookingType.resource: screen = GeneralDetailScreen(type: BookingType.resource, id: widget.id,);
      case BookingType.car: screen = GeneralDetailScreen(type: BookingType.car, id: widget.id,);
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  void didTapCancelButton() { Navigator.of(context).pop(); }

  void didTapRemoveBookingButton() {
    print('didTapRemoveBookingButton');
  }
}
