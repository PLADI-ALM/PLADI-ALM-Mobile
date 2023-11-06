import 'package:flutter/material.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';
import 'package:frontend/View/notification/component/notification_cell.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SubAppBar(
        titleText: '알림',
      ),
      body: renderBody(),
    );
  }

  Widget renderBody() {
    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 7),
      children: const [
        Text(
          '2023.11.02',
          style: TextStyle(
            color: Color(0xFF717171),
            fontSize: 14,
            fontFamily: 'NanumSquare_ac',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        NotificationCell(type: NotificationType.Approve),
        NotificationCell(type: NotificationType.Cancel),
        NotificationCell(type: NotificationType.End),
        NotificationCell(type: NotificationType.Request),
        NotificationCell(type: NotificationType.Return)
      ],
    );
  }
}
