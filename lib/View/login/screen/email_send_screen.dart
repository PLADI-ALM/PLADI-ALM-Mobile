import 'package:flutter/material.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';

class EmailSendScreen extends StatefulWidget {
  const EmailSendScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailSendScreen();
}

class _EmailSendScreen extends State<EmailSendScreen> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode codeFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    codeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          emailFocusNode.unfocus();
          codeFocusNode.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const SubAppBar(titleText: "비밀번호 재설정"),
          body: renderBody(),
          backgroundColor: Colors.white,
          bottomNavigationBar: PurpleBottomButton(
            title: "다음",
            onPressed: moveChangePw,
          ),
        ));
  }

  Widget renderBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(top: 70, left: 21, right: 19),
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 20,
            child: Text("이메일",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 250,
                  height: 32,
                  child: TextField(
                    maxLines: 1,
                    focusNode: emailFocusNode,
                    obscureText: false,
                    controller: emailController,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF640FAF))),
                        isDense: true,
                        hintText: "이메일 입력",
                        contentPadding: EdgeInsets.all(10)),
                  )),
              SizedBox(
                width: 80,
                height: 42,
                child: ElevatedButton(
                  onPressed: getCode,
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF640FAF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                  child: const Text(
                    "인증요청",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            width: double.infinity,
            height: 20,
            margin: const EdgeInsets.only(top: 10, bottom: 25),
            child: const Text("인증번호",
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
            height: 30,
            child: TextField(
              maxLines: 1,
              focusNode: codeFocusNode,
              obscureText: false,
              controller: codeController,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF640FAF))),
                  isDense: true,
                  hintText: "인증번호 입력",
                  contentPadding: EdgeInsets.all(10)),
            ),
          )
        ],
      ),
    );
  }

  void getCode() {}

  void moveChangePw() {}
}
