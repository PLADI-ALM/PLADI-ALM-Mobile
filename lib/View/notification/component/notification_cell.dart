import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum NotificationType {
  Request('asset/image/clock_notification.png', "장비 예약 요청"),
  Approve('asset/image/check_notification.png', "장비 예약 승인"),
  Cancel('asset/image/cancel_notification.png', "장비 예약 반려"),
  Return('asset/image/check_notification.png', "장비 예약 반납"),
  End('asset/image/time_notification.png', "장비 예약 종료");

  const NotificationType(this.image, this.title);

  final String image;
  final String title;
}

class NotificationCell extends StatefulWidget {
  const NotificationCell({super.key});

  @override
  State<NotificationCell> createState() => _NotificationCellState();
}

class _NotificationCellState extends State<NotificationCell> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('asset/image/time_notification'),
        const Column(
          children: [Text("장비 예약 요청"), Text("차루비님이 맥북 예약을 요청하셨습니다.")],
        )
      ],
    );
  }
}
