import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/Presenter/booking/car_service.dart';
import 'package:frontend/Presenter/booking/office_service.dart';
import 'package:frontend/Presenter/booking/resource_service.dart';
import 'package:frontend/View/booking/screen/office_filter_screen.dart';
import 'package:frontend/View/colors.dart';

import '../screen/booking_screen.dart';
import '../screen/general_filter_screen.dart';

class CustomSearchBar extends StatefulWidget {
  final BookingType type;

  const CustomSearchBar({
    required this.type,
    Key? key
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (getKeyword().isEmpty) {
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
                child: TextFormField(
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
    switch (widget.type) {
      case BookingType.office: return '시설 검색';
      case BookingType.resource: return '장비명 검색';
      case BookingType.car: return '차량명 검색';
    }
  }

  String getKeyword() {
    switch(widget.type) {
      case BookingType.office: return OfficeService().keyword;
      case BookingType.resource: return ResourceService().keyword;
      case BookingType.car: return CarService().keyword;
    }
  }

  bool isFilterInfoEmpty() {
    switch(widget.type) {
      case BookingType.office: return OfficeService().isFilterInfoEmpty();
      case BookingType.resource: return ResourceService().isFilterInfoEmpty();
      case BookingType.car: return CarService().isFilterInfoEmpty();
    }
  }

  /// Event Methods
  void didTapFilterButton() {
    switch (widget.type) {
      case BookingType.office:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OfficeFilterScreen()));
      case BookingType.resource:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GeneralFilterScreen(type: BookingType.resource,)));
      case BookingType.car:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GeneralFilterScreen(type: BookingType.car,)));
    }
  }

  void didChangedSearchBar() {
    BookingScreenState? parent = context.findAncestorStateOfType<BookingScreenState>();
    parent!.searchItems((controller.value.text.isEmpty) ? '' : controller.value.text);
  }

  void didEditingComplete() {
    FocusScope.of(context).unfocus();
    BookingScreenState? parent = context.findAncestorStateOfType<BookingScreenState>();
    parent!.searchItems((controller.value.text.isEmpty) ? '' : controller.value.text);
  }
}
