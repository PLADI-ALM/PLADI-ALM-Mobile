import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectTimeButton extends StatefulWidget {

  final VoidCallback onPressed;
  final String title;

  const SelectTimeButton({
    required this.onPressed,
    required this.title,
    Key? key
  }) : super(key: key);

  @override
  State<SelectTimeButton> createState() => _SelectTimeButtonState();
}

class _SelectTimeButtonState extends State<SelectTimeButton> {

  TextStyle style = const TextStyle(fontSize: 13, color: Color(0xFFC9C9C9));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: const Color(0xFF939393))
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        child: Row(
          children: [
            Text(widget.title, style: style,),
            Flexible(child: Container()),
            const Icon(CupertinoIcons.clock, size: 24, color: Colors.black,)
          ],
        )
      ),
    );
  }
}
