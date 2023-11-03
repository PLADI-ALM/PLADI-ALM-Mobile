import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Presenter/notification/notification_firebase.dart';

import 'View/common/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeNotification();
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
          body: SplashScreen(),
        ));
  }
}
