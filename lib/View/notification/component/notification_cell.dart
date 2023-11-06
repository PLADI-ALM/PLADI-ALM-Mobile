import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum NotificationType {
  Request('asset/image/clock_notification.svg', "장비 예약 요청"),
  Approve('asset/image/check_notification.svg', "장비 예약 승인"),
  Cancel('asset/image/cancel_notification.svg', "장비 예약 반려"),
  Return('asset/image/check_notification.svg', "장비 예약 반납"),
  End('asset/image/time_notification.svg', "장비 예약 종료");

  const NotificationType(this.image, this.title);

  final String image;
  final String title;
}

class NotificationCell extends StatefulWidget {
  final NotificationType type;

  const NotificationCell({super.key, required this.type});

  @override
  State<NotificationCell> createState() => _NotificationCellState();
}

class _NotificationCellState extends State<NotificationCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: ShapeDecoration(
        color: const Color(0xFFF7F3FB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 17, left: 12, bottom: 20),
            child: SvgPicture.asset(
              widget.type.image,
              width: 33,
              height: 33,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, left: 16, bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    widget.type.title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xFF2A2A2A),
                      fontSize: 12,
                      fontFamily: 'NanumSquare_ac',
                      fontWeight: FontWeight.w400,
                      height: 0.14,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: const Text(
                    "차루비님이 맥북 예약을 요청하셨습니다.",
                    style: TextStyle(
                      color: Color(0xFF2A2A2A),
                      fontSize: 12,
                      fontFamily: 'NanumSquare_ac',
                      fontWeight: FontWeight.w400,
                      height: 0.14,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
