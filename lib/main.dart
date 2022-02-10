import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gms/menu/main_menu.dart';
import 'package:flutter_gms/splash_screen.dart';
import 'package:flutterfire_ui/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Gachon Herald',
      theme: ThemeData(primaryColor: Colors.lightBlue),
      darkTheme: ThemeData.dark(),

      // 처음 앱에 접속할 때 SplashScreen class를 호출하도록 만든다.
      home: const SplashScreen(),
    );
  }
}

class Messaging extends StatefulWidget {
  const Messaging({Key? key}) : super(key: key);

  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  // Firebase에서 알림을 받을 수 있도록 firebase_messaging을 이용해 코드를 작성
  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      if (kDebugMode) {
        // Firebase에서 메시지를 보낼 때 필요한 토큰 출력
        print(value);
      }
    });

    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        print("message received");
      }
      if (kDebugMode) {
        print(event.notification!.body);
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // Firebase 알람
            return AlertDialog(
              title: const Text("Notification"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // 로그인 창인 Authentication으로 이동
      body: Authentication(),
    );
  }
}

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // Firebase Authentication과 연동하여 사용자의 로그인 정보를 확인한다
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(
              headerBuilder: (context, constraints, d) {
                return const Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: AspectRatio(
                    aspectRatio: 1,
                    // 로그인 창 꾸미기
                    child: Text(
                      "Welcome to\n Gachon Herald!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
              // Flutter 2.0에서 제공해주는 기본 로그인 창 불러오기
              providerConfigs: const [EmailProviderConfiguration()],
            );
          }
          // 로그인이 끝나면 메인 메뉴로 이동
          return const MainMenu();
        });
  }
}
