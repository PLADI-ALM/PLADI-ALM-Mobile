import 'package:flutter/material.dart';
import 'package:frontend/View/colors.dart';

import '../../booking/screen/booking_screen.dart';
import '../component/tabbar_item.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: tabBarIcons.length, vsync: this);
    controller.addListener(tabListener);
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

  /// 화면 중앙 UI 구현 메소드 ///
  Widget renderTabBarView() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      children: [
        const BookingScreen(),
        const BookingScreen(),
        const BookingScreen(),
        const BookingScreen(),
        // EquipmentScreen(),
        // ArchivingScreen(),
        // MypageScreen(),
      ],
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
        items: tabBarIcons,
      ),
    );
  }

  TextStyle renderLabelStyle() {
    return TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500
    );
  }
}
