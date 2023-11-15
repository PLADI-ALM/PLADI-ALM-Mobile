import 'package:flutter/material.dart';
import 'package:frontend/Presenter/login/login_service.dart';
import 'package:frontend/View/common/component/purple_bottom_button.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';
import 'package:frontend/View/login/screen/login_screen.dart';

class PasswordScreen extends StatefulWidget {
  final String email;
  const PasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailSendScreen();
}

class _EmailSendScreen extends State<PasswordScreen> {
  FocusNode passwordFocusNode = FocusNode();
  FocusNode checkPasswordFocusNode = FocusNode();

  TextEditingController passwordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    checkPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          passwordFocusNode.unfocus();
          checkPasswordFocusNode.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const SubAppBar(titleText: "비밀번호 재설정"),
          body: renderBody(),
          backgroundColor: Colors.white,
          bottomNavigationBar: PurpleBottomButton(
            title: "확인",
            onPressed: changePw,
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
            child: Text("새 비밀번호",
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
              height: 32,
              child: TextField(
                maxLines: 1,
                focusNode: passwordFocusNode,
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF640FAF))),
                    isDense: true,
                    hintText: "새 비밀번호 입력",
                    contentPadding: EdgeInsets.all(10)),
              )),
          const SizedBox(
            height: 40,
          ),
          Container(
            width: double.infinity,
            height: 20,
            margin: const EdgeInsets.only(top: 10, bottom: 25),
            child: const Text("비밀번호 확인",
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
              focusNode: checkPasswordFocusNode,
              obscureText: true,
              controller: checkPasswordController,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF640FAF))),
                  isDense: true,
                  hintText: "새 비밀번호 재입력",
                  contentPadding: EdgeInsets.all(10)),
            ),
          )
        ],
      ),
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
                Text("비밀번호 재설정 오류"),
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

  void changePw() {
    var password = passwordController.text;
    var checkPassword = checkPasswordController.text;
    if (password == checkPassword) {
      Future<dynamic> result =
          LoginService().changePassword(widget.email, password);
      result.then((value) => {
            if (value == true)
              {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false)
              }
            else if (value == false)
              {showAlert("알 수 없는 오류가 발생했습니다. 다시 시도해주세요.")}
            else
              {showAlert(value)}
          });
    } else {
      showAlert("비밀번호와 재입력 비밀번호가 다릅니다. 다시 시도해주세요.");
    }
  }
}
