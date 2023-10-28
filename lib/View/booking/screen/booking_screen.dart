import 'package:flutter/material.dart';
import 'package:frontend/View/colors.dart';
import 'package:frontend/View/common/component/main_app_bar.dart';

import '../component/custom_search_bar.dart';
import '../component/office_item.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {

  late final TabController controller;
  int index = 0;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(tabListener);
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
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
      height: 292.0 * 10 + 300, // TODO: 10을 data 개수로 수정
      child: ListView(
        children: [
          renderTabBar(),
          const CustomSearchBar(),
          renderItems()
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
          renderTabItem('회의실'),
          renderTabItem('차량'),
          renderTabItem('차량')
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
  
  Widget renderItems() {
    return Container(
      // height: 292.0 * data.length,
      height: 292.0 * 10,
      color: Colors.white,
      child:
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        // itemCount: data.length,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return OfficeItem();
        },
      ),
    );
  }

}
