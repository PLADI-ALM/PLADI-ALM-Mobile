import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/View/booking/screen/office_filter_screen.dart';
import 'package:frontend/View/colors.dart';

class CustomSearchBar extends StatefulWidget {
  final bool isOfficeBooking;
  const CustomSearchBar({
    required this.isOfficeBooking,
    Key? key
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 36,
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(CupertinoIcons.search, color: Colors.black,),
          ),
          Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: TextField(
                  cursorColor: purple,
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: '시설 검색',
                    hintStyle: TextStyle(fontSize: 13, color: Color(0xFFC9C9C9)),
                    border: InputBorder.none,
                  ),
                ),
              )
          ),
          IconButton(
            onPressed: didTapFilterButton,
            icon: SvgPicture.asset('asset/image/filter.svg'),
            style: IconButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10)
            ),
          )
        ],
      ),
    );
  }

  /// Event Methods
  void didTapFilterButton() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => (widget.isOfficeBooking)
            ? const OfficeFilterScreen() : const OfficeFilterScreen())
        // TODO: widget.isOfficeBooking == false 인 경우 그 외 필터 화면으로 이동시키기
    );
  }
}
