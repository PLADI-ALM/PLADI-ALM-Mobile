import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/View/mybooking/component/booking_status_item.dart';

import '../../booking/screen/booking_screen.dart';
import '../../colors.dart';
import '../../common/component/main_app_bar.dart';
import '../component/booking_item_card.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> with SingleTickerProviderStateMixin {

  static const category = ['회의실', '장비', '차량'];
  BookingType currentType = BookingType.office;

  late final TabController controller;
  int selectedTab = 0;


  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainAppBar(),
      body: renderBody(),
    );
  }


  Widget renderBody() {
    return SizedBox(
      child: Column(
        children: [
          renderTabBar(),
          const SizedBox(height: 10,),
          Expanded(
            child: TabBarView(
              controller: controller,
              children:
              category.map((e) => renderItems(e)).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget renderTabBar() {
    const TextStyle selectedTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    const TextStyle unSelectedTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    return SizedBox(
      height: 38,
      child: TabBar(
          controller: controller,
          isScrollable: true,
          indicatorColor: purple,
          indicatorWeight: 3.0,
          indicatorPadding: const EdgeInsets.only(left: 10, right: 10),
          labelColor: purple,
          labelStyle: selectedTextStyle,
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: unSelectedTextStyle,
          tabs: [
            renderTabItem(category[0]),
            renderTabItem(category[1]),
            renderTabItem(category[2]),
          ]
      ),
    );
  }

  Widget renderTabItem(String title) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 100) / 3 ,
      child: Tab(icon: Text(title),),
    );
  }

  Widget renderItems(String categoryName) {
    return Container(
      height: 250 * 12,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          return BookingItemCard();
        },
      ),
    );
  }

  /// Helper Methods
  void tabListener() {
    setState(() {
      FocusScope.of(context).unfocus();
      switch (controller.index) {
        case 0: currentType = BookingType.office;
        case 1: currentType = BookingType.resource;
        case 2: currentType = BookingType.car;
      }
    });
  }
}
