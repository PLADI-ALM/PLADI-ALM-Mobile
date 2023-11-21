import 'package:flutter/material.dart';
import 'package:frontend/Model/model/booking/resource_model.dart';
import 'package:frontend/View/booking/screen/booking_screen.dart';

import '../../colors.dart';
import '../screen/general_detail_screen.dart';

class ResourceItem extends StatefulWidget {
  final ResourceInfo data;

  const ResourceItem({required this.data, Key? key}) : super(key: key);

  @override
  State<ResourceItem> createState() => _ResourceItemState();
}

class _ResourceItemState extends State<ResourceItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: didTapResourceItem,
      child: Container(
        height: 232,
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
                child: (widget.data.imgUrl == null)
                    ? Image.asset('asset/image/pladi_icon.png')
                    : Image.network(widget.data.imgUrl!, fit: BoxFit.fitWidth)),
            renderResourceInfo(),
          ],
        ),
      ),
    );
  }

  Widget renderResourceInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text(
            widget.data.name,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600, color: purple),
          ),
          const SizedBox(width: 5,),
          Text(
            widget.data.manufacturer ?? '제조사 미기입',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF717171)),
          ),
          Flexible(child: Container()),
          Text(
            widget.data.location ?? '보관장소 미기입',
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF717171)),
          )
        ],
      ),
    );
  }

  /// Event Methods
  void didTapResourceItem() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => GeneralDetailScreen(
              type: BookingType.resource,
              id: widget.data.resourceId,
            )));
  }
}
