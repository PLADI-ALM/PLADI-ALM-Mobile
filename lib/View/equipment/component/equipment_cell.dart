import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/Model/model/equipment/equipment_list_model.dart';
import 'package:frontend/View/colors.dart';

class EquipmentCell extends StatefulWidget {
  final EquipmentModel equipment;

  const EquipmentCell({super.key, required this.equipment});

  @override
  State<EquipmentCell> createState() => _EquipmentCellState();
}

class _EquipmentCellState extends State<EquipmentCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showDetail,
      child: equipmentCell(),
    );
  }

  Widget equipmentCell() {
    return Container(
        width: double.infinity,
        height: 120,
        decoration: ShapeDecoration(
          color: const Color(0xFFFCFBFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.76),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x517A7A7B),
              blurRadius: 19.20,
              offset: Offset(0, 7.68),
              spreadRadius: 0,
            )
          ],
        ),
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 14, left: 14, bottom: 14),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: (widget.equipment.imgUrl == null)
                      ? Image.asset('asset/image/pladi_icon.png')
                      : Image.network(widget.equipment.imgUrl!,
                          fit: BoxFit.fill),
                )),
            Container(
              margin: const EdgeInsets.only(
                  top: 17, left: 10, bottom: 14, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 65,
                        height: 22,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF640FAF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          widget.equipment.category,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'NanumSquare_ac',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.equipment.name,
                        style: const TextStyle(
                          color: Color(0xFF640FAF),
                          fontSize: 15,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.10,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.equipment.quantity,
                        style: const TextStyle(
                          color: Color(0xFF717171),
                          fontSize: 13,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.10,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'asset/image/mypage_icon.svg',
                        width: 22,
                        height: 22,
                      ),
                      Container(
                        width: 10,
                      ),
                      Text(
                        "${widget.equipment.keeper}(${widget.equipment.contact})",
                        style: const TextStyle(
                          color: Color(0xFF717171),
                          fontSize: 13,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.10,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'asset/image/location.svg',
                        width: 22,
                        height: 22,
                      ),
                      Container(
                        width: 10,
                      ),
                      Text(
                        widget.equipment.location == null
                            ? "보관 장소"
                            : widget.equipment.location!,
                        style: const TextStyle(
                          color: Color(0xFF717171),
                          fontSize: 13,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.10,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  void showDetail() {
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
                              onPressed: editEquipment,
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
                              onPressed: showDeleteSheet,
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
                  child: (widget.equipment.imgUrl == null)
                      ? Image.asset('asset/image/pladi_icon.png')
                      : Image.network(
                          widget.equipment.imgUrl!,
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
                      widget.equipment.category,
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
                      widget.equipment.name,
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
                      widget.equipment.quantity,
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
                      "${widget.equipment.keeper}(${widget.equipment.contact})",
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
                      widget.equipment.location == null
                          ? "보관 장소"
                          : widget.equipment.location!,
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
                        widget.equipment.description == null
                            ? "설명"
                            : widget.equipment.description!,
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
        });
  }

  void showDeleteSheet() {
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
                          onPressed: deleteEquipment,
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
        });
  }

  void didTapCancelButton() {
    Navigator.of(context).pop();
  }

  void editEquipment() {}

  void deleteEquipment() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
