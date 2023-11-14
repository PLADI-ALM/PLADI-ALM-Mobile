import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/Model/model/general_model.dart';
import 'package:frontend/Model/model/mypage/profile_response.dart';
import 'package:frontend/Model/network/api_manager.dart';
import 'package:frontend/Presenter/mypage/mypage_service.dart';
import 'package:frontend/View/common/component/sub_app_bar.dart';
import 'package:frontend/View/login/screen/login_screen.dart';
import 'package:frontend/View/mypage/component/mypage_cell.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MypageScreen();
}

class _MypageScreen extends State<MypageScreen> {
  late final ProfileResponse data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SubAppBar(titleText: "내정보"), body: renderBody());
  }

  Widget renderBody() {
    return FutureBuilder(
        future: MypageService().getProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            data = ProfileResponse(name: "이름", role: "역할");
            return mypageBody(data);
          }

          if (snapshot.hasData) {
            data = ProfileResponseModel.fromJson(snapshot.data).data;
            return mypageBody(data);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget mypageBody(ProfileResponse profile) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'asset/image/mypage_icon.svg',
                      width: 22,
                      height: 22,
                    ),
                    Container(
                      width: 11,
                    ),
                    Text(
                      profile.name,
                      style: const TextStyle(
                        color: Color(0xFF4C4C4C),
                        fontSize: 20,
                        fontFamily: 'NanumSquare_ac',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: 0.40,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 30,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.72, vertical: 1.18),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF640FAF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    profile.role,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'NanumSquare_ac',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          GestureDetector(
            onTap: moveToService,
            child: const MypageCell(title: "서비스 이용약관"),
          ),
          GestureDetector(
            onTap: moveToInfo,
            child: const MypageCell(title: "개인정보 처리방침"),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          GestureDetector(
            onTap: logout,
            child: const MypageCell(title: "로그아웃"),
          ),
          GestureDetector(
            onTap: logout,
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '회원탈퇴',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF717171),
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
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
                Text("내정보 불러오기 오류"),
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

  void moveToService() {}

  void moveToInfo() {}

  void logout() {
    Future<dynamic> result = MypageService().logout();
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
  }

  void deleteUser() {}
}
