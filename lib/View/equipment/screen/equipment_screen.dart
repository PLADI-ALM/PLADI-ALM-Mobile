import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/Model/model/equipment/equipment_list_model.dart';
import 'package:frontend/Presenter/equipment/equipment_service.dart';
import 'package:frontend/View/common/component/main_app_bar.dart';
import 'package:frontend/View/equipment/component/equipment_cell.dart';
import 'package:frontend/View/equipment/screen/equipment_add_screen.dart';

class EquipmentScreen extends StatefulWidget {
  const EquipmentScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EquipmentScreen();
}

class _EquipmentScreen extends State<EquipmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: futureBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          moveToAddEquipment();
        },
        tooltip: 'Increment',
        backgroundColor: const Color(0xFF640FAF),
        child: addButton(),
      ),
    );
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

  Widget addButton() {
    return Container(
      width: 48,
      height: 48,
      decoration: const ShapeDecoration(
        color: Color(0xFF640FAF),
        shape: OvalBorder(),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          'asset/image/plus.svg',
          width: 22,
          height: 22,
        ),
      ),
    );
  }

  void moveToAddEquipment() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const EquipmentAddScreen()));
  }
}
