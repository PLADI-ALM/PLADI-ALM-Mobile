import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/Model/model/equipment/equipment_list_model.dart';
import 'package:frontend/Presenter/equipment/equipment_service.dart';
import 'package:frontend/View/colors.dart';
import 'package:frontend/View/common/component/main_app_bar.dart';
import 'package:frontend/View/equipment/component/equipment_cell.dart';
import 'package:frontend/View/equipment/screen/equipment_add_screen.dart';

class EquipmentScreen extends StatefulWidget {
  const EquipmentScreen({super.key});

  @override
  State<StatefulWidget> createState() => EquipmentScreenState();
}

class EquipmentScreenState extends State<EquipmentScreen>
    with SingleTickerProviderStateMixin {
  String cond = "";
  TextEditingController condController = TextEditingController();
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
    return FutureBuilder<dynamic>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return noDataBody();
          }

          if (snapshot.hasData) {
            notificationList =
                EquipmentResponseModel.fromJson(snapshot.data).data.content;
            return renderBody(notificationList);
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
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 36,
          decoration: const BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  CupertinoIcons.search,
                  color: Colors.black,
                ),
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: TextFormField(
                  cursorColor: purple,
                  controller: condController,
                  decoration: const InputDecoration(
                    hintText: "비품 검색",
                    hintStyle:
                        TextStyle(fontSize: 13, color: Color(0xFFC9C9C9)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              )),
            ],
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.7,
            color: Colors.white,
            child: equipmentList.isEmpty
                ? noDataBody()
                : ListView.builder(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 7),
                    scrollDirection: Axis.vertical,
                    itemCount: equipmentList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => showDetail(equipmentList[index]),
                        child: EquipmentCell(equipment: equipmentList[index]),
                      );
                    },
                  ))
      ],
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

  void showDetail(EquipmentModel equipment) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: didTapCancelButton,
                          icon: SvgPicture.asset(
                            'asset/image/cancel.svg',
                            width: 15,
                            height: 15,
                          )),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () => editEquipment(equipment),
                              child: const Text(
                                '수정',
                                style: TextStyle(
                                  color: Color(0xFF640FAF),
                                  fontSize: 12,
                                  fontFamily: 'NanumSquare_ac',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.08,
                                ),
                              )),
                          TextButton(
                              onPressed: () => showDeleteSheet(equipment),
                              child: const Text(
                                '삭제',
                                style: TextStyle(
                                  color: Color(0xFF640FAF),
                                  fontSize: 12,
                                  fontFamily: 'NanumSquare_ac',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.08,
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: (equipment.imgUrl == null)
                      ? Image.asset('asset/image/pladi_icon.png')
                      : Image.network(
                          equipment.imgUrl!,
                          fit: BoxFit.fill,
                        ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 51,
                      child: Text(
                        '카테고리',
                        style: TextStyle(
                          color: Color(0xFF717171),
                          fontSize: 14,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      equipment.category,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'NanumSquare_ac',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 51,
                      child: Text(
                        '비품명',
                        style: TextStyle(
                          color: Color(0xFF717171),
                          fontSize: 14,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      equipment.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'NanumSquare_ac',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 51,
                      child: Text(
                        '수량',
                        style: TextStyle(
                          color: Color(0xFF717171),
                          fontSize: 14,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      equipment.quantity,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'NanumSquare_ac',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 51,
                      child: Text(
                        '책임자',
                        style: TextStyle(
                          color: Color(0xFF717171),
                          fontSize: 14,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      "${equipment.keeper}(${equipment.contact})",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'NanumSquare_ac',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 51,
                      child: Text(
                        '보관장소',
                        style: TextStyle(
                          color: Color(0xFF717171),
                          fontSize: 14,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      equipment.location == null
                          ? "보관 장소"
                          : equipment.location!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'NanumSquare_ac',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 51,
                      child: Text(
                        '설명',
                        style: TextStyle(
                          color: Color(0xFF717171),
                          fontSize: 14,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 100),
                      child: Text(
                        equipment.description == null
                            ? "설명"
                            : equipment.description!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          );
        }).then((value) {
      setState(() {});
    });
  }

  void showDeleteSheet(EquipmentModel equipment) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 180,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '비품을 삭제하시겠습니까?',
                  style: TextStyle(fontSize: 16, color: Color(0xFF656565)),
                ),
                const SizedBox(
                  height: 30,
                ),
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
                                  side: const BorderSide(
                                      color: Color(0xFFC9C9C9)))),
                          child: const Text(
                            '취소',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF717171)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => deleteEquipment(equipment),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                          child: const Text(
                            '확인',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }).then((value) {
      setState(() {});
    });
  }

  void moveToAddEquipment() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const EquipmentAddScreen()))
        .then((value) {
      setState(() {});
    });
  }

  Future<dynamic> fetchData() async {
    cond = condController.text;
    return EquipmentService().getEquipment(cond);
  }

  void reloadData() {
    setState(() {});
  }

  void didTapCancelButton() {
    Navigator.of(context).pop();
  }

  void editEquipment(EquipmentModel equipment) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (_) => EquipmentAddScreen(equipment: equipment)))
        .then((value) {
      setState(() {});
    });
  }

  void deleteEquipment(EquipmentModel equipment) {
    Future<dynamic> result =
        EquipmentService().deleteEquipment(equipment.equipmentId);
    result.then((value) => {
          if (value == true)
            {Navigator.of(context).pop(), Navigator.of(context).pop()}
          else
            {Fluttertoast.showToast(msg: value)}
        });
  }

  void popNavi() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
