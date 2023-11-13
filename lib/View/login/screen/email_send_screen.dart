import 'package:flutter/material.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';

class EmailSendScreen extends StatefulWidget {
  const EmailSendScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EmailSendScreen();
}

class _EmailSendScreen extends State<EmailSendScreen> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode pwFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SubAppBar(titleText: "비밀번호 재설정"), body: renderBody());
  }

  Widget renderBody() {
    return Column(
      children: [
        const Text("이메일"),
        Row(
          children: [
            TextField(
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
            ),
            TextButton(onPressed: getCode, child: const Text("인증 요청"))
          ],
        ),
        const Text("인증번호"),
        TextField(
          maxLines: 1,
          focusNode: emailFocusNode,
          obscureText: false,
          controller: emailController,
          decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF640FAF))),
              isDense: true,
              hintText: "인증번호 입력",
              contentPadding: EdgeInsets.all(10)),
        ),
      ],
    );
  }

  void getCode() {}
}
