import 'package:flutter/material.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';

class GeneralFilterScreen extends StatefulWidget {

  final String appBarTitle;

  const GeneralFilterScreen({
    required this.appBarTitle,
    Key? key
  }) : super(key: key);

  @override
  State<GeneralFilterScreen> createState() => _GeneralFilterScreenState();
}

class _GeneralFilterScreenState extends State<GeneralFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubAppBar(titleText: widget.appBarTitle,),
      body: renderBody(),
      bottomNavigationBar: PurpleBottomButton(title: '적용', onPressed: didTapApplyButton,),
    );
  }

  Widget renderBody() {
    return Container(

    );
  }

  /// Event Methods
  void didTapApplyButton() {
    print('didTapApplyButton');
  }
}
