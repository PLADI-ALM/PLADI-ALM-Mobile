import 'package:flutter/material.dart';
import 'package:frontend/View/login/screen/login_screen.dart';

import 'View/common/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // 시뮬레이터 오른쪽 상단에 'debug' 배너 삭제
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'NanumSquare',
        ),
        home: const Scaffold(
          body: LoginScreen(),
        )
    );
  }
}