import 'package:flutter/material.dart';
import 'package:frontend/Model/model/notification/notification_response.dart';
import 'package:frontend/Presenter/notification/notification_service.dart';
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
        body: futureBody());
  }

  Widget futureBody() {
    List<NotificationModel> notificationList;
    return FutureBuilder(
        future: NotificationService().getNotification(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return noDataBody();
          }

          if (snapshot.hasData) {
            notificationList =
                NotificationResponseModel.fromJson(snapshot.data).data.content;
            if (notificationList.isEmpty) {
              return noDataBody();
            } else {
              return renderBody(notificationList);
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget noDataBody() {
    return Center(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: const Text("알림이 없습니다.",
          style: TextStyle(fontSize: 16, color: Colors.purple)),
    ));
  }

  Widget renderBody(List<NotificationModel> notificationList) {
    String date = notificationList[0].createdAt;
    return ListView.builder(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 7),
      scrollDirection: Axis.vertical,
      itemCount: notificationList.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return NotificationCell(
              notification: notificationList[index], changeDate: true);
        } else {
          if (date != notificationList[index].createdAt) {
            date = notificationList[index].createdAt;
            return NotificationCell(
                notification: notificationList[index], changeDate: true);
          } else {
            return NotificationCell(
                notification: notificationList[index], changeDate: false);
          }
        }
      },
    );
  }
}
