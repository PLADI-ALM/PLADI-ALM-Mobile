import 'package:flutter/material.dart';
import 'package:frontend/Presenter/booking/resource_service.dart';
import 'package:frontend/View/booking/screen/booking_screen.dart';

import '../../../Presenter/booking/car_service.dart';
import '../../../Presenter/booking/office_service.dart';
import '../../colors.dart';
import '../screen/mybooking_screen.dart';
import 'booking_status_item.dart';

enum BookingManageType { cancel, giveBack, reject, permit  }  // 취소, 반납, 반려, 허가

class BookingItemCard extends StatefulWidget {
  final bool isAdmin;
  final BookingType type;
  final int id;
  final String name;
  final String? location;
  final String startDateTime;
  final String endDateTime;
  final String? memo;
  final String status;

  const BookingItemCard({
    required this.isAdmin,
    required this.type,
    required this.id,
    required this.name,
    required this.location,
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

  MyBookingScreenState? parent;

  @override
  void initState() {
    super.initState();
    parent = context.findAncestorStateOfType<MyBookingScreenState>();
  }

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
                  Text(widget.location ?? '장소 미기입', style: locationStyle,)
                ],
              ),
              Expanded(child: Container()),
              SizedBox(
                child: IconButton(onPressed: (){},
                    style: IconButton.styleFrom(padding: EdgeInsets.zero),
                    icon: const Icon(Icons.arrow_forward_ios, size: 16,)
                ),
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
                Expanded(child: Text(widget.memo ?? '미기입', style: contentStyle, textAlign: TextAlign.justify,))
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

    if (widget.isAdmin) {
      switch (bookingStatus) {
        case '예약중':
          return Row(
            children: [
              Expanded(child: Container()),
              TextButton(
                child: Text(getManageBookingTypeStr(BookingManageType.reject), style: buttonStyle,),
                onPressed: () { showCancelBookingBottomSheet(BookingManageType.reject); },
              )
            ],
          );
        case '사용중':
          return Row(
            children: [
              Expanded(child: Container()),
              TextButton(
                child: Text(getManageBookingTypeStr(BookingManageType.giveBack), style: buttonStyle,),
                onPressed: () { showCancelBookingBottomSheet(BookingManageType.giveBack); },
              )
            ],
          );
        case '예약대기':
          return Row(
            children: [
              Expanded(child: Container()),
              TextButton(
                child: Text(getManageBookingTypeStr(BookingManageType.permit), style: buttonStyle,),
                onPressed: () { showCancelBookingBottomSheet(BookingManageType.permit); },
              ),
              TextButton(
                child: Text(getManageBookingTypeStr(BookingManageType.reject), style: buttonStyle,),
                onPressed: () { showCancelBookingBottomSheet(BookingManageType.reject); },
              )
            ],
          );
        default: return const SizedBox(height: 0,);
      }
    } else {
      switch (bookingStatus) {
        case '예약중':
        case '예약대기':
          return Row(
            children: [
              Expanded(child: Container()),
              TextButton(
                child: Text(getManageBookingTypeStr(BookingManageType.cancel), style: buttonStyle,),
                onPressed: () { showCancelBookingBottomSheet(BookingManageType.cancel); },
              )
            ],
          );
        case '사용중':
          return Row(
            children: [
              Expanded(child: Container()),
              TextButton(
                child: Text(getManageBookingTypeStr(BookingManageType.giveBack), style: buttonStyle,),
                onPressed: () { showCancelBookingBottomSheet(BookingManageType.giveBack); },
              )
            ],
          );
        default: return const SizedBox(height: 0,);
      }
    }
  }

  void showCancelBookingBottomSheet(BookingManageType type) {
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
                Text('예약을 ${getManageBookingTypeStr(type)}하시겠습니까?',
                  style: const TextStyle(fontSize: 16, color: Color(0xFF656565)),
                ),
                const SizedBox(height: 30,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
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
                      const SizedBox(width: 10,),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: getManageBookingTypeEvent(type),
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
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  String getManageBookingTypeStr(BookingManageType type) {
    switch (type) {
      case BookingManageType.cancel: return '취소';
      case BookingManageType.reject: return '반려';
      case BookingManageType.giveBack: return '반납';
      case BookingManageType.permit: return '허가';
   }
  }

  VoidCallback getManageBookingTypeEvent(BookingManageType type) {
    switch (type) {
      case BookingManageType.cancel: return didTapCancelBookingButton;
      case BookingManageType.reject: return didTapRejectBookingButton;
      case BookingManageType.giveBack: return didTapGiveBackBookingButton;
      case BookingManageType.permit: return didTapPermitBookingButton;
    }
  }

  /// Event Methods ///
  void didTapCancelButton() { Navigator.of(context).pop(); }

  void didTapCancelBookingButton() async {
    Navigator.of(context).pop();
    parent!.changeLoadingStatus(true);
    dynamic response;
    switch(widget.type) {
      case BookingType.office: response = await OfficeService().cancelBooking(widget.id);
      case BookingType.resource: response = await ResourceService().cancelBooking(widget.id);
      case BookingType.car: response = await CarService().cancelBooking(widget.id);
    }
    parent!.changeLoadingStatus(false);
    parent!.reloadData(response);
  }

  void didTapRejectBookingButton() {
    print('didTapRejectBookingButton');
  }

  void didTapGiveBackBookingButton() {
    print('didTapGiveBackBookingButton');
  }

  void didTapPermitBookingButton() {
    print('didTapPermitBookingButton');
  }

}
