import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MypageCell extends StatefulWidget {
  final String title;

  const MypageCell({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _MypageCell();
}

class _MypageCell extends State<MypageCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.title,
            style: const TextStyle(
              color: Color(0xFF404040),
              fontSize: 15,
              fontFamily: 'NanumSquare_ac',
              fontWeight: FontWeight.w400,
              height: 0,
              letterSpacing: 0.38,
            ),
          ),
          SvgPicture.asset(
            'asset/image/right_arrow.svg',
            width: 15,
            height: 15,
          )
        ],
      ),
    );
  }
}
