import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const iconWidth = 26.0;
const iconHeight = 26.0;

final tabBarIcons = [
  BottomNavigationBarItem(
    icon: SvgPicture.asset("asset/image/tab_icon/booking_unselected.svg", width: iconWidth, height: iconHeight),
    activeIcon: SvgPicture.asset("asset/image/tab_icon/booking_selected.svg", width: iconWidth, height: iconHeight),
    label: '예약',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset("asset/image/tab_icon/equipment_unselected.svg", width: iconWidth, height: iconHeight),
    activeIcon: SvgPicture.asset("asset/image/tab_icon/equipment_selected.svg", width: iconWidth, height: iconHeight),
    label: '비품 내역',
  ),
  BottomNavigationBarItem(
      icon: SvgPicture.asset("asset/image/tab_icon/mypage_unselected.svg", width: iconWidth, height: iconHeight),
      activeIcon: SvgPicture.asset("asset/image/tab_icon/mypage_selected.svg", width: iconWidth, height: iconHeight),
      label: 'My 예약'
  ),
];