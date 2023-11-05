import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectTimeButton extends StatefulWidget {

  final VoidCallback onPressed;
  final String title;
  final bool isContentInit;

  const SelectTimeButton({
    required this.onPressed,
    required this.title,
    required this.isContentInit,
    Key? key
  }) : super(key: key);

  @override
  State<SelectTimeButton> createState() => _SelectTimeButtonState();
}

class _SelectTimeButtonState extends State<SelectTimeButton> {

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 13, color: widget.isContentInit ? Colors.black : const Color(0xFFC9C9C9));

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
