import 'package:flutter/material.dart';
import 'package:flutter_gms/article.dart';
import 'package:flutter_gms/set/setting_info.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

String? fF;
double? fS;
double? tS;
Color? tC;
Color? bC;


String recentFont = "roboto";

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Column(
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(width: 2.0),
                                left: BorderSide(width: 2.0),
                                right: BorderSide(width: 2.0),
                                bottom: BorderSide(width: 2.0))),
                        child: SettingChanger(
                            MediaQuery.of(context).size.width * 0.7)),

                    // 글자색
                  ],
                ),
              )
            ],
          )),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width * 0.5,
                  alignment: Alignment.center,
                  child: const Text(
                    "초기화",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      border: Border.all(color: Colors.black87)),
                ),
              ),
              // 취소
              GestureDetector(
                onTap: () {
                  articlefontfamily = fF;
                  articletextspace = fS;
                  articletextsize = tS;
                  articletextcolor = tC;
                  articlebackgroundcolor = bC;
                  setState(() {});
                  Navigator.pop(context, true);
                },
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width * 0.5,
                  alignment: Alignment.center,
                  child: const Text(
                    "적용",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[300],
                      border: Border.all(color: Colors.black87)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
