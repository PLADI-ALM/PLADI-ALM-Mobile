import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/Model/model/equipment/equipment_list_model.dart';
import 'package:frontend/Model/model/notification/notification_response.dart';

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
          color: const Color(0xFFF7F3FB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 14, left: 14, bottom: 14),
                child: (widget.equipment.imgUrl == null)
                    ? Image.asset('asset/image/pladi_icon.png')
                    : Image.network(widget.equipment.imgUrl!,
                        fit: BoxFit.fitWidth)),
            Container(
              margin: const EdgeInsets.only(
                  top: 17, left: 10, bottom: 14, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 65,
                        height: 30,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.72, vertical: 1.18),
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
                          height: 0.10,
                          letterSpacing: 0.10,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.equipment.quantity.toString(),
                        style: const TextStyle(
                          color: Color(0xFF717171),
                          fontSize: 13,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w700,
                          height: 0.14,
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
                          height: 0.14,
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
                          height: 0.14,
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
