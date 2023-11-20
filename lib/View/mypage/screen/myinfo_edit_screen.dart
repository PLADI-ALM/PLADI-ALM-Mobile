import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/Model/model/mypage/profile_response.dart';
import 'package:frontend/Presenter/mypage/mypage_service.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';
import 'package:frontend/View/login/screen/login_screen.dart';
import 'package:frontend/View/mypage/component/mypage_cell.dart';

class MyInfoEditScreen extends StatefulWidget {
  const MyInfoEditScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MyInfoEditScreen();
}

class _MyInfoEditScreen extends State<MyInfoEditScreen> {
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode assetsFocusNode = FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController assetController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    assetsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          nameFocusNode.unfocus();
          phoneFocusNode.unfocus();
          assetsFocusNode.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const SubAppBar(titleText: "내 정보 수정"),
          body: renderBody(),
          backgroundColor: Colors.white,
          bottomNavigationBar: PurpleBottomButton(
            title: "수정",
            onPressed: changeMyInfo,
          ),
        ));
  }

  Widget renderBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(top: 50, left: 21, right: 19),
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 20,
            child: Text("성명",
                style: TextStyle(
                  color: Color(0xFF4C4C4C),
                  fontSize: 16,
                  fontFamily: 'NanumSquare_ac',
                  fontWeight: FontWeight.w700,
                  height: 0,
                )),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
              width: double.infinity,
              height: 42,
              child: TextField(
                maxLines: 1,
                focusNode: nameFocusNode,
                obscureText: true,
                controller: nameController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Color(0xFF939393))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Color(0xFF640FAF))),
                    isDense: true,
                    hintText: "성명",
                    contentPadding: EdgeInsets.all(10)),
              )),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: double.infinity,
            height: 20,
            margin: const EdgeInsets.only(top: 10, bottom: 25),
            child: const Text("연락처",
                style: TextStyle(
                  color: Color(0xFF4C4C4C),
                  fontSize: 16,
                  fontFamily: 'NanumSquare_ac',
                  fontWeight: FontWeight.w700,
                  height: 0,
                )),
          ),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: TextField(
              maxLines: 1,
              focusNode: phoneFocusNode,
              obscureText: false,
              controller: phoneController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                NumberFormatter(),
                LengthLimitingTextInputFormatter(13)
              ],
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF939393))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF640FAF))),
                  isDense: true,
                  hintText: "연락처",
                  contentPadding: EdgeInsets.all(10)),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: double.infinity,
            height: 20,
            margin: const EdgeInsets.only(top: 10, bottom: 25),
            child: const Text("부여자산",
                style: TextStyle(
                  color: Color(0xFF4C4C4C),
                  fontSize: 16,
                  fontFamily: 'NanumSquare_ac',
                  fontWeight: FontWeight.w700,
                  height: 0,
                )),
          ),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: TextField(
              maxLines: 1,
              focusNode: assetsFocusNode,
              obscureText: true,
              controller: assetController,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF939393))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF640FAF))),
                  isDense: true,
                  hintText: "부여자산",
                  contentPadding: EdgeInsets.all(10)),
            ),
          )
        ],
      ),
    );
  }

  void changeMyInfo() {}
}

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex <= 3) {
        if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); // Add double spaces.
        }
      } else {
        if (nonZeroIndex % 7 == 0 &&
            nonZeroIndex != text.length &&
            nonZeroIndex > 4) {
          buffer.write('-');
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
