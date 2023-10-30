import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/Presenter/booking/booking_service.dart';
import 'package:frontend/View/colors.dart';

import '../screen/booking_screen.dart';

class CustomSearchBar extends StatefulWidget {
  final int index;

  const CustomSearchBar({
    required this.index,
    Key? key
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (BookingService().getKeyword().isEmpty) {
      controller = TextEditingController();
    }
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
                  decoration: InputDecoration(
                    hintText: getHintText(),
                    hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFC9C9C9)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {didChangedSearchBar();},
                  onEditingComplete: didEditingComplete,
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

  /// Helper Methods
  String getHintText() {
    switch (widget.index) {
      case 0: return '시설 검색';
      case 1: return '차량명 검색';
      case 2: return '장비명 검색';
    }
    return '검색';
  }

  /// Event Methods
  void didTapFilterButton() {
    print('didTapFilterButton');
  }

  void didChangedSearchBar() {
    BookingScreenState? parent = context.findAncestorStateOfType<BookingScreenState>();
    if (controller.value.text.isNotEmpty) {
      parent!.searchItems(controller.value.text);
    }
  }

  void didEditingComplete() { FocusScope.of(context).unfocus(); }
}
