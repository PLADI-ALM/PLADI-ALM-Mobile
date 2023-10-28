import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);
  static const double appBarHeight = 50;

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

class _MainAppBarState extends State<MainAppBar> {

  @override
  Widget build(BuildContext context) {
    return renderAppBar();
  }

  /// rendering methods
  AppBar renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Image.asset('asset/image/app_bar_icon.png'),
      centerTitle: false,
      actions: renderRightItems(),
      elevation: 0,
    );
  }

  List<Widget> renderRightItems() {
    Widget notificationItem = IconButton(
      onPressed: didTapNotificationButton,
      icon: SvgPicture.asset('asset/image/notification.svg'),
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero
      ),
    );

    Widget sideBarItem = IconButton(
      onPressed: didTapSideBarButton,
      icon: SvgPicture.asset('asset/image/side_bar.svg'),
      style: IconButton.styleFrom(
          padding: EdgeInsets.zero
      ),
    );

    return [notificationItem, sideBarItem];
  }

  /// event methods
  void didTapNotificationButton() {
    print('didTapNotificationButton');
  }

  void didTapSideBarButton() {
    print('didTapNotificationButton');
  }
}
