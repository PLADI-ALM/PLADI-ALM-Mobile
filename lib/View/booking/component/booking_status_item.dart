import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 예약중, 사용중, 사용완료, 예약취소, 예약대기

class BookingStatusItem extends StatefulWidget {
  final String status;

  const BookingStatusItem({
    required this.status,
    Key? key
  }) : super(key: key);

  @override
  State<BookingStatusItem> createState() => _BookingStatusItemState();
}

class _BookingStatusItemState extends State<BookingStatusItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: getBackColor(),
        borderRadius: const BorderRadius.all(Radius.circular(7))
      ),
      child: Row(
        children: [
          Icon(CupertinoIcons.circle_fill, size: 6, color: getContentColor(),),
          const SizedBox(width: 4,),
          Text(widget.status, style: TextStyle(fontSize: 11, color: getContentColor()),)
        ],
      ),
    );
  }

  Color getBackColor() {
    switch (widget.status) {
      case '예약중': return const Color(0xFFFFF0D7);
      case '사용중': return const Color(0xFFDAE6FF);
      case '사용완료': return const Color(0xFFECFDF3);
      case '예약취소': return const Color(0xFFFFDFD7);
      case '예약대기': return const Color(0xFFEBEBEB);
      default: return Colors.white;
    }
  }

  Color getContentColor() {
    switch (widget.status) {
      case '예약중': return const Color(0xFFF19B0A);
      case '사용중': return const Color(0xFF2A63F6);
      case '사용완료': return const Color(0xFF027A48);
      case '예약취소': return const Color(0xFFEC6240);
      case '예약대기': return const Color(0xFF4C4C4C);
      default: return Colors.white;
    }
  }
}
