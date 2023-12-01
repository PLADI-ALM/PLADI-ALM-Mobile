import 'package:flutter/material.dart';
import 'package:frontend/Model/model/equipment/equipment_list_model.dart';
import 'package:frontend/Presenter/equipment/equipment_service.dart';
import 'package:frontend/View/common/component/main_app_bar.dart';
import 'package:frontend/View/equipment/component/equipment_cell.dart';

class EquipmentScreen extends StatefulWidget {
  const EquipmentScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EquipmentScreen();
}

class _EquipmentScreen extends State<EquipmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const MainAppBar(), body: futureBody());
  }

  Widget futureBody() {
    List<EquipmentModel> notificationList;
    return FutureBuilder(
        future: EquipmentService().getEquipment(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return noDataBody();
          }

          if (snapshot.hasData) {
            notificationList =
                EquipmentResponseModel.fromJson(snapshot.data).data.content;
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
      child: const Text("비품 목록이 없습니다.",
          style: TextStyle(fontSize: 16, color: Colors.purple)),
    ));
  }

  Widget renderBody(List<EquipmentModel> equipmentList) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 7),
      scrollDirection: Axis.vertical,
      itemCount: equipmentList.length,
      itemBuilder: (BuildContext context, int index) {
        return EquipmentCell(equipment: equipmentList[index]);
      },
    );
  }
}
