import 'package:flutter/material.dart';
import 'package:frontend/View/colors.dart';

class OfficeItem extends StatefulWidget {
  const OfficeItem({Key? key}) : super(key: key);

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
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Image.asset('asset/image/office_sample.png')),
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
              Text('회의실', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: purple),),
              const SizedBox(width: 8,),
              Text('401호', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF717171)),),
              Flexible(child: Container()),
              Text('6명', style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Color(0xFF717171)),)
            ],
          ),
          Divider(color: Color(0xFF4C4C4C).withOpacity(0.6),),
          const SizedBox(height: 3,),
          Row(
            children: [
              renderFacilityItem('빔 프로젝터'),
              renderFacilityItem('마이크'),
              renderFacilityItem('화상회의'),
              Flexible(child: Container()),
              Text('외 2개', style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Color(0xFF717171)),)
            ],
          )
        ],
      ),
    );
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
