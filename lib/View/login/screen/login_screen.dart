import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Presenter/login/login_service.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';

import '../../common/component/purple_bottom_button.dart';


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
      onTap: (){
        emailFocusNode.unfocus();
        pwFocusNode.unfocus();
      },
      child:Scaffold(
        body: renderBody()
      )
    );
  }

  Widget renderBody() {
    return Column(
        children: [
          Center(
              child: Column(
                children: [
                  Container(
                    child: titleColumn(),
                    margin: EdgeInsets.only(bottom: 70),
                  ),

                  Container(
                    child: textFiledColumn(),
                    margin: EdgeInsets.only(left: 40, right: 40, bottom: 62),
                  ),

                  Row(
                    children: [
                      Flexible(
                        child: Container(
                              child: ElevatedButton(
                                  onPressed: login,
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Color(0xFF640FAF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )
                                  ),
                                  child: Text("로그인", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              ),
                          height: 50,
                          margin: EdgeInsets.only(left: 40, right: 40, bottom: 14),
                        ),

                        fit: FlexFit.tight,
                        ),
                    ],
                  ),
                ],
              )
          ),

          Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                  )
                )
              ),
              child: Container(
                child: TextButton(
                  onPressed: findPw,
                  child: Text(
                    '비밀번호 재설정',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF717171),
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                margin: EdgeInsets.only(left: 200),
              )
          )


        ],
      );
  }

  Widget titleColumn() {
    TextStyle titleStyle = const TextStyle(color: Color(0xFF640FAF), fontSize: 18, fontFamily: 'NanumSquare_ac', fontWeight: FontWeight.w700,);
    return Column(
      children: [
        Container(
          child: Image.asset('asset/image/pladi_icon.png'),
          margin: EdgeInsets.only(top: 153, bottom: 8),
        ),
        Text("사내 관리 페이지", style: titleStyle,)
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
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF640FAF))
                ),
                isDense: true,
                hintText: "이메일",
                prefixIcon: Image.asset("asset/image/login_email.png"),
                contentPadding: EdgeInsets.all(10)
            ),
          ),
        ),


        SizedBox(height: 40,),

        SizedBox(
          height: 32,
          child: TextField(
            maxLines: 1,
            focusNode: pwFocusNode,
            obscureText: true,
            controller: pwController,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF640FAF))
                ),
                isDense: true,
                hintText: "비밀번호",
                prefixIcon: Image.asset("asset/image/login_pw.png"),
                contentPadding: EdgeInsets.all(10)
            ),
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
            title: Column(
              children: <Widget>[
                new Text("로그인 오류"),
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
                child: Text(
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
      if (value == true) {

      }else if (value == false) {

      }else {
        showAlert(value)
      }
    });
  }
  
  void findPw() {
    print("find pw");
  }
}