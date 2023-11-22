import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AdminRightButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AdminRightButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  State<AdminRightButton> createState() => _AdminRightButtonState();
}

class _AdminRightButtonState extends State<AdminRightButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset("asset/image/tab_icon/admin_history.svg"),
      onPressed: widget.onPressed,
    );
  }
}
