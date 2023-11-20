import 'package:flutter/material.dart';
import 'package:frontend/View/colors.dart';

import '../../common/component/purple_bottom_button.dart';
import '../../common/component/sub_app_bar.dart';

class BookingReturnScreen extends StatefulWidget {
  const BookingReturnScreen({Key? key}) : super(key: key);

  @override
  State<BookingReturnScreen> createState() => _BookingReturnScreenState();
}

class _BookingReturnScreenState extends State<BookingReturnScreen> {

  bool isReturn = false;
  bool isReturnPossible = false;

  TextEditingController locationController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SubAppBar(titleText: '반납',),
      body: renderBody(),
      bottomNavigationBar: PurpleBottomButton(title: '반납', onPressed: isReturnPossible ? didTapReturnButton : null,),
    );
  }

  Widget renderBody() {
    TextStyle titleStyle = const TextStyle(fontSize: 16, color: Color(0xFF4C4C4C), fontWeight: FontWeight.bold);
    TextStyle hintStyle = const TextStyle(fontSize: 13, color: Color(0xFFC9C9C9));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(text: TextSpan(
              style: titleStyle,
              children: const [
                TextSpan(text: '반납장소\(현재위치\)'),
                TextSpan(text: ' *', style: TextStyle(fontSize: 14, color: Color(0xFFEC6240), fontWeight: FontWeight.bold)),
              ])
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xFF939393))
            ),
            child: TextField(
              controller: locationController,
              cursorColor: purple,
              onChanged: (value) { checkInput(); },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: hintStyle,
                hintText: '반납장소를 입력해주세요.',
              ),
            ),
          ),
          const SizedBox(height: 30,),

          // 특이사항 입력란
          Text('특이사항', style: titleStyle,),
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: const Color(0xFF939393))
            ),
            child: TextField(
              controller: remarkController,
              maxLength: 100,
              cursorColor: purple,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: hintStyle,
                hintText: '파손 및 분실 등 특이사항이 있는 경우 입력해주세요.',
              ),
            ),
          ),
          const SizedBox(height: 30,),

          // 반납장소에 반납하였는지 여부 체크박스
          GestureDetector(
            onTap: (){
              setState(() {
                isReturn = !isReturn;
                checkInput();
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 20, height: 20,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      border: Border.all(color: isReturn ? Colors.white : const Color(0xFF4C4C4C)),
                      color: isReturn ? purple : Colors.white
                  ),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('반납장소에 반납하셨나요?', style: titleStyle,),
                    const SizedBox(height: 5,),
                    RichText(text: const TextSpan(
                        style: TextStyle(fontSize: 14, color: Color(0xFFC9C9C9)),
                        children: [
                          TextSpan(text: '차량의 경우 '),
                          TextSpan(text: '차키 ', style: TextStyle(fontSize: 14, color: Color(0xFFEC6240))),
                          TextSpan(text: '반납까지 완료 후, 작성해주세요'),
                        ])
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  void checkInput() {
    setState(() {
      isReturnPossible = isReturn && locationController.value.text.isNotEmpty;
    });
  }

  void didTapReturnButton() {
    print('didTapReturnButton');
  }
}
