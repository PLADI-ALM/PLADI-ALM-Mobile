import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/View/colors.dart';

class BookingSuccessScreen extends StatefulWidget {
  const BookingSuccessScreen({Key? key}) : super(key: key);

  @override
  State<BookingSuccessScreen> createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: renderBody(),
      bottomNavigationBar: renderBottomButton(),
    );
  }

  Widget renderBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.check_mark_circled_solid, color: purple, size: MediaQuery.of(context).size.width / 3,),
          const SizedBox(height: 20,),
          const Text('예약이 완료되었습니다.\n감사합니다.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black, height: 1.5),
          )
        ],
      ),
    );
  }

  Widget renderBottomButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 18, bottom: 25),
            width: (MediaQuery.of(context).size.width - 50) / 2,
            height: 44,
            child: ElevatedButton(
                onPressed: didTapConfirmButton,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Color(0xFFC9C9C9))
                  )
                ),
                child: const Text('확인', style: TextStyle(fontSize: 14, color: darkGrey),)
            ),
          ),
          const SizedBox(width: 10,),
          Container(
            margin: const EdgeInsets.only(right: 18, bottom: 25),
            width: (MediaQuery.of(context).size.width - 50) / 2,
            height: 44,
            child: ElevatedButton(
                onPressed: didTapMyBookingButton,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
                child: const Text('My 예약', style: TextStyle(fontSize: 14, color: Colors.white),)
            ),
          ),
        ],
      ),
    );
  }


  void didTapConfirmButton() {
    print('didTapConfirmButton');
  }

  void didTapMyBookingButton() {
    print('didTapMyBookingButton');
  }
}
