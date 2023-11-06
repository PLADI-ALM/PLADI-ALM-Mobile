import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef SetSelectedTime = void Function(DateTime time);

class SelectTimeButton extends StatefulWidget {
  final String initialTitle;
  final String bottomSheetTopTitle;
  final SetSelectedTime changeTime;

  const SelectTimeButton({
    required this.initialTitle,
    required this.bottomSheetTopTitle,
    required this.changeTime,
    Key? key
  }) : super(key: key);

  @override
  State<SelectTimeButton> createState() => _SelectTimeButtonState();
}

class _SelectTimeButtonState extends State<SelectTimeButton> {

  DateTime? selectedTime;
  String hintText = '';

  @override
  void initState() {
    super.initState();
    hintText = widget.initialTitle;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 13, color: (selectedTime != null) ? Colors.black : const Color(0xFFC9C9C9));

    return Container(
      height: 42,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: const Color(0xFF939393))
      ),
      child: TextButton(
          onPressed: showBottomTimePicker,
          child: Row(
            children: [
              Text(hintText, style: style,),
              Flexible(child: Container()),
              const Icon(CupertinoIcons.clock, size: 24, color: Colors.black,)
            ],
          )
      ),
    );
  }

  void showBottomTimePicker() {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext buildContext) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              child: Container(
                  height: 305,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: Row(
                          children: [
                            const SizedBox(width: 15,),
                            Text(widget.bottomSheetTopTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                            Flexible(child: Container()),
                            IconButton(
                                onPressed: (){Navigator.of(context).pop();},
                                icon: const Icon(CupertinoIcons.xmark, color: Colors.black, size: 24,)
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 245,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          onDateTimeChanged: (DateTime time) {
                            setState(() {
                              selectedTime = time;
                              hintText = DateFormat('HH:mm').format(selectedTime!);
                              widget.changeTime(selectedTime!);
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  )
              ),
            ),
          );
        }
    );
  }
}
