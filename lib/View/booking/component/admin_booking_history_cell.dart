import 'package:flutter/material.dart';

import '../screen/booking_history_screen.dart';
import 'booking_status_item.dart';

class AdminBookingHistoryCell extends StatefulWidget {
  final String reservatorName;
  final String reservatorPhone;
  final String startDateTime;
  final String endDateTime;
  final String? goal;
  final String bookingStatus;

  const AdminBookingHistoryCell(
      {required this.reservatorName,
      required this.reservatorPhone,
      required this.startDateTime,
      required this.endDateTime,
      required this.goal,
      required this.bookingStatus,
      Key? key})
      : super(key: key);

  @override
  State<AdminBookingHistoryCell> createState() =>
      _AdminBookingHistoryCellState();
}

class _AdminBookingHistoryCellState extends State<AdminBookingHistoryCell> {
  TextStyle nameStyle = const TextStyle(
      fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle locationStyle =
      const TextStyle(fontSize: 12, color: Color(0xFF959595));

  TextStyle titleStyle =
      const TextStyle(fontSize: 12, color: Color(0xFF959595));
  TextStyle contentStyle =
      const TextStyle(fontSize: 12, color: Color(0xFF1B2128));

  BookingHistoryScreenState? parent;

  @override
  void initState() {
    super.initState();
    parent = context.findAncestorStateOfType<BookingHistoryScreenState>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: const Color(0xFFC9C9C9))),
        child: Container(
          margin:
              const EdgeInsets.only(right: 17, left: 17, top: 11, bottom: 11),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 43,
                    child: Text(
                      '예약자',
                      style: titleStyle,
                    ),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  Text('${widget.reservatorName} (${widget.reservatorPhone})',
                      style: contentStyle, overflow: TextOverflow.ellipsis)
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 43,
                    child: Text(
                      '예약일시',
                      style: titleStyle,
                    ),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  Text('${widget.startDateTime} ~ ${widget.endDateTime}',
                      style: contentStyle, overflow: TextOverflow.ellipsis)
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 43,
                    child: Text(
                      '이용목적',
                      style: titleStyle,
                    ),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  Text(
                    widget.goal ?? '미기입',
                    style: contentStyle,
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 43,
                    child: Text(
                      '예약상태',
                      style: titleStyle,
                    ),
                  ),
                  Expanded(child: Container()),
                  BookingStatusItem(status: widget.bookingStatus),
                ],
              ),
            ],
          ),
        ));
  }
}
