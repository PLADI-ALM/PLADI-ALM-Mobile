import 'package:flutter/material.dart';
import 'package:frontend/View/colors.dart';

import '../../../Model/model/booking/office_model.dart';

class OfficeItem extends StatefulWidget {

  final OfficeInfo data;

  const OfficeItem({
    required this.data,
    Key? key
  }) : super(key: key);

  @override
  State<OfficeItem> createState() => _OfficeItemState();
}

class _OfficeItemState extends State<OfficeItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 272,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 4,
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 176,
            margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: (widget.data.imgUrl == null || widget.data.imgUrl.contains('null'))
                  ? Image.asset('asset/image/pladi_icon.png')
                  : Image.network(widget.data.imgUrl, fit: BoxFit.fitWidth)
          ),
          renderOfficeInfo(),
        ],
      ),
    );
  }

  Widget renderOfficeInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.data.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: purple),),
              const SizedBox(width: 8,),
              Text(widget.data.location, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF717171)),),
              Flexible(child: Container()),
              Text('${widget.data.capacity}명', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Color(0xFF717171)),)
            ],
          ),
          Divider(color: const Color(0xFF4C4C4C).withOpacity(0.6),),
          const SizedBox(height: 3,),
          renderFacilityRow(widget.data.facilityList)
        ],
      ),
    );
  }

  Widget renderFacilityRow(List<String?> facilityList) {
    if (facilityList.isNotEmpty) {
      List<Widget> items = [];
      if (facilityList.length > 3) {
        for(int i=0; i<3; i++) {
          items.add(renderFacilityItem(facilityList[i]!));
        }
      } else {
        items = facilityList.map((e) =>
            renderFacilityItem(e!)
        ).toList();
      }

      items.add(Flexible(child: Container()));
      items.add(
        (facilityList.length > 3)
            ? Text('외 ${facilityList.length-3}개', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Color(0xFF717171)),)
            : Container()
      );
      return Row(children: items);

    } else {
      return const Row(
        children: [
          Text('편의시설 없음', style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Color(0xFF717171)),)
        ],
      );
    }
  }

  Widget renderFacilityItem(String name) {
    return Container(
      margin: const EdgeInsets.only(right: 7,),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: purple, width: 0.5)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7),
        child: Text(name, style: const TextStyle(fontSize: 11, color: purple),),
      ),
    );
  }

}
