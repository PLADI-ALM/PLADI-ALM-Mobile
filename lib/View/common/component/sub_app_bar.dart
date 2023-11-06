import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../colors.dart';

class SubAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? titleText;
  final List<Widget>? rightItems;
  final bool? isBackItemHidden;

  static const double appBarHeight = 50;

  const SubAppBar(
      {required this.titleText,
      this.rightItems,
      this.isBackItemHidden,
      Key? key})
      : super(key: key);

  @override
  State<SubAppBar> createState() => _SubAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

class _SubAppBarState extends State<SubAppBar> {
  final titleStyle = const TextStyle(color: Colors.black, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return renderAppBar();
  }

  /// rendering methods
  AppBar renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: (widget.titleText != null)
          ? Text(
              widget.titleText!,
              style: titleStyle,
            )
          : const Text(''),
      centerTitle: true,
      leading: (widget.isBackItemHidden ?? false) ? null : renderLeftItem(),
      actions: widget.rightItems,
      elevation: 0,
    );
  }

  Widget renderLeftItem() {
    return IconButton(
      icon: SvgPicture.asset("asset/image/chevron_backward.svg"),
      onPressed: didTapBackItem,
    );
  }

  /// event methods
  void didTapBackItem() {
    Navigator.of(context).pop();
  }
}
