import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/Model/model/equipment/equipment_list_model.dart';
import 'package:frontend/Presenter/equipment/equipment_service.dart';
import 'package:frontend/View/colors.dart';
import 'package:frontend/View/equipment/screen/equipment_add_screen.dart';
import 'package:frontend/View/equipment/screen/equipment_screen.dart';

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
    return equipmentCell();
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
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
}
