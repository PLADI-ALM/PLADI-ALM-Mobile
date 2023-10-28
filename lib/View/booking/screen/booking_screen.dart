import 'package:flutter/material.dart';
import 'package:frontend/View/common/component/main_app_bar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: renderBody(),
    );
  }

  Widget renderBody() {
    return Container();
  }
}
