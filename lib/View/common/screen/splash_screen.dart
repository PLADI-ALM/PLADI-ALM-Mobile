import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/View/colors.dart';
import 'package:frontend/View/common/screen/root_tab.dart';

import '../../../Model/network/api_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPurple,
      body: Center(
        child: Image.asset('asset/image/pladi_icon.png'),
      ),
    );
  }

  Future<void> checkToken() async {

    /// Access / Refresh Token 저장 여부 확인 (있으면 홈 화면, 없으면 로그인 화면으로 전환)
    if (await APIManager().checkToken()) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const RootTab()), (route) => false);

    } else {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (_) => LoginScreen()),
      //         (route) => false);
    }
  }
}
