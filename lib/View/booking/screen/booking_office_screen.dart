import 'package:flutter/material.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';

import '../../common/component/purple_bottom_button.dart';

class BookingOfficeScreen extends StatefulWidget {
  const BookingOfficeScreen({Key? key}) : super(key: key);

  @override
  State<BookingOfficeScreen> createState() => _BookingOfficeScreenState();
}

class _BookingOfficeScreenState extends State<BookingOfficeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SubAppBar(titleText: '회의실 예약',),
      body: renderBody(),
      bottomNavigationBar: PurpleBottomButton(title: '예약', onPressed: didTapBookingButton,),
    );
  }

  Widget renderBody() {
    return Container();
  }

  void didTapBookingButton() {
    print('didTapBookingButton');
  }
}
