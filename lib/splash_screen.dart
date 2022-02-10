import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gms/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // splash screen이 작동하는 시간 정해주기 (만약 앱이 켜지는 데 6초가 걸려도 10초로 설정했기 때문에 10초 후에 켜짐
    // splash screen이 중간에 끊기지 않게 하기 위해 10초로 설정
    Timer(const Duration(milliseconds: 10000), () {
      Navigator.push(
        // splash가 끝난 후 Messaging() -> Authentication() -> MainMenu()로 이동
          context, MaterialPageRoute(builder: (context) => const Messaging()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          // 미리 만들어 놓은 gif 사진 추가
          child: Image.asset(
            'assets/loader.gif',
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}