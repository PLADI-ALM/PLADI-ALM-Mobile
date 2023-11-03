import 'package:flutter/material.dart';
import 'package:frontend/Presenter/login/login_service.dart';

import '../../common/screen/root_tab.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode pwFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    pwFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          emailFocusNode.unfocus();
          pwFocusNode.unfocus();
        },
        child: Scaffold(resizeToAvoidBottomInset: false, body: renderBody()));
  }

  Widget renderBody() {
    return Column(
      children: [
        Center(
            child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 70),
              child: titleColumn(),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40, bottom: 62),
              child: textFiledColumn(),
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    height: 50,
                    margin:
                        const EdgeInsets.only(left: 40, right: 40, bottom: 14),
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFF640FAF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      child: const Text(
                        "로그인",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
        Theme(
            data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ))),
            child: Container(
              margin: const EdgeInsets.only(left: 200),
              child: TextButton(
                onPressed: findPw,
                child: const Text(
                  '비밀번호 재설정',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF717171),
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ))
      ],
    );
  }

  Widget titleColumn() {
    TextStyle titleStyle = const TextStyle(
      color: Color(0xFF640FAF),
      fontSize: 18,
      fontFamily: 'NanumSquare_ac',
      fontWeight: FontWeight.w700,
    );
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 153, bottom: 8),
          child: Image.asset('asset/image/pladi_icon.png'),
        ),
        Text(
          "사내 관리 페이지",
          style: titleStyle,
        )
      ],
    );
  }

  Widget textFiledColumn() {
    return Column(
      children: [
        SizedBox(
          height: 32,
          child: TextField(
            maxLines: 1,
            focusNode: emailFocusNode,
            obscureText: false,
            controller: emailController,
            decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF640FAF))),
                isDense: true,
                hintText: "이메일",
                prefixIcon: Image.asset("asset/image/login_email.png"),
                contentPadding: const EdgeInsets.all(10)),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          height: 32,
          child: TextField(
            maxLines: 1,
            focusNode: pwFocusNode,
            obscureText: true,
            controller: pwController,
            decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF640FAF))),
                isDense: true,
                hintText: "비밀번호",
                prefixIcon: Image.asset("asset/image/login_pw.png"),
                contentPadding: const EdgeInsets.all(10)),
          ),
        ),
      ],
    );
  }

  void showAlert(String content) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: const Column(
              children: <Widget>[
                Text("로그인 오류"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(content),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "확인",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void login() {
    var email = emailController.text;
    var password = pwController.text;

    Future<dynamic> result = LoginService().login(email, password);
    result.then((value) => {
          if (value == true)
            {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const RootTab()),
                  (route) => false)
            }
          else if (value == false)
            {showAlert("알 수 없는 오류가 발생했습니다. 다시 시도해주세요.")}
          else
            {showAlert(value)}
        });
  }

  void findPw() {
    print("find pw");
  }
}
