import 'package:flutter/material.dart';
import 'package:frontend/View/colors.dart';

class PurpleBottomButton extends StatefulWidget {

  final String title;
  final VoidCallback? onPressed;

  const PurpleBottomButton({
    required this.title,
    required this.onPressed,
    Key? key
  }) : super(key: key);

  @override
  State<PurpleBottomButton> createState() => _PurpleBottomButtonState();
}

class _PurpleBottomButtonState extends State<PurpleBottomButton> {
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, bottom: 25),
      height: 44,
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )
          ),
          child: Text(widget.title, style: titleStyle,)
      ),
    );
  }
}
