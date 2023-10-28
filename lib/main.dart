import 'package:flutter/material.dart';

import 'View/common/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, // 시뮬레이터 오른쪽 상단에 'debug' 배너 삭제
        home: Scaffold(
          body: SplashScreen(),
        )
    );
  }
}