import 'package:flutter/material.dart';
import 'package:frontend/Model/network/api_manager.dart';
import 'package:frontend/View/colors.dart';

import '../../admin/screen/admin_screen.dart';
import '../../booking/screen/booking_screen.dart';
import '../../mybooking/screen/mybooking_screen.dart';
import '../component/tabbar_item.dart';

class RootTab extends StatefulWidget {

  final int? initialIndex;

  const RootTab({
    this.initialIndex,
    Key? key
  }) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;
  int selectedTab = 0;

  void setTabControllerByRole() async {
    controller = APIManager().isAdmin
        ? TabController(length: adminTabBarIcons.length, vsync: this)
        : TabController(length: basicTabBarIcons.length, vsync: this);
    controller.addListener(tabListener);
    index = widget.initialIndex ?? 0;
    selectedTab = widget.initialIndex ?? 0;
  }

  @override
  void initState() {
    super.initState();

    controller = TabController(
        length: APIManager().isAdmin ? adminTabBarIcons.length : basicTabBarIcons.length,
        vsync: this
    );
    controller.addListener(tabListener);
    index = widget.initialIndex ?? 0;
    selectedTab = widget.initialIndex ?? 0;
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: renderTabBarView(),
      bottomNavigationBar: renderBottomNavBar(),
    );
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  List<Widget> getTabBarItemList() {
    if (APIManager().isAdmin) {
      return [
        const BookingScreen(),
        const BookingScreen(),
        const MyBookingScreen(),
        const AdminScreen(),
      ];
    } else {
      return [
        const BookingScreen(),
        const BookingScreen(),
        const MyBookingScreen(),
      ];
    }
  }

  /// 화면 중앙 UI 구현 메소드 ///
  Widget renderTabBarView() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      children: getTabBarItemList()
    );
  }

  /// 하단 탭바 구현 메소드 ///
  Container renderBottomNavBar() {
    return Container(
      color: Colors.white,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: purple,
        unselectedItemColor: Colors.black,

        selectedLabelStyle: renderLabelStyle(),
        unselectedLabelStyle: renderLabelStyle(),
        type: BottomNavigationBarType.fixed,

        onTap: (index){
          controller.animateTo(index);
          setState(() {
            selectedTab = 0;
          });
        },
        currentIndex: index,
        items: APIManager().isAdmin ? adminTabBarIcons : basicTabBarIcons,
      ),
    );
  }

  TextStyle renderLabelStyle() {
    return const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500
    );
  }
}
