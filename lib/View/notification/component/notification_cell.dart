import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/Model/model/notification/notification_response.dart';

enum NotificationType {
  Request('asset/image/clock_notification.svg', "장비 예약 요청"),
  Approve('asset/image/check_notification.svg', "장비 예약 승인"),
  Complete('asset/image/check_notification.svg', "장비 예약 완료"),
  Cancel('asset/image/cancel_notification.svg', "장비 예약 반려"),
  Return('asset/image/check_notification.svg', "장비 예약 반납"),
  End('asset/image/time_notification.svg', "장비 예약 종료");

  const NotificationType(this.image, this.title);

  final String image;
  final String title;
}

class NotificationCell extends StatefulWidget {
  final NotificationModel notification;
  final bool changeDate;

  const NotificationCell(
      {super.key, required this.notification, required this.changeDate});

  @override
  State<NotificationCell> createState() => _NotificationCellState();
}

class _NotificationCellState extends State<NotificationCell> {
  NotificationType type = NotificationType.Request;

  void getType() {
    switch (widget.notification.notificationType) {
      case "장비 예약 요청":
        type = NotificationType.Request;
        break;
      case "장비 예약 완료":
        type = NotificationType.Complete;
        break;
      case "장비 예약 승인":
        type = NotificationType.Approve;
        break;
      case "장비 예약 반려":
        type = NotificationType.Cancel;
        break;
      case "장비 예약 반납":
        type = NotificationType.Return;
        break;
      case "장비 예약 종료":
        type = NotificationType.End;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getType();
    return widget.changeDate ? DateCell() : noDateCell();
  }

  Widget noDateCell() {
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
                type.image,
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
                      type.title,
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
                    child: Text(
                      widget.notification.notificationInfo,
                      style: const TextStyle(
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
        ));
  }

  Widget DateCell() {
    return SizedBox(
        width: double.infinity,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.notification.createdAt,
              style: const TextStyle(
                color: Color(0xFF717171),
                fontSize: 14,
                fontFamily: 'NanumSquare_ac',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            Container(
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
                      margin:
                          const EdgeInsets.only(top: 17, left: 12, bottom: 20),
                      child: SvgPicture.asset(
                        type.image,
                        width: 33,
                        height: 33,
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 30, left: 16, bottom: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              type.title,
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
                            child: Text(
                              widget.notification.notificationInfo,
                              style: const TextStyle(
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
                )),
          ],
        ));
  }
}
