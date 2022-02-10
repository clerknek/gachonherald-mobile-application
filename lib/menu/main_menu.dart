import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gms/article.dart';
import 'package:flutter_gms/article_info.dart';
import 'package:flutter_gms/data/article_data.dart';
import 'package:flutter_gms/menu/sub_menu.dart';
import 'package:flutter_gms/search.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

// article_info.dart에서 기사 데이터 가져오기
final aInfos = rPageInfo();

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('The Gachon Herald', style: TextStyle(fontFamily: 'enbrush'),),
          centerTitle: true,
          actions: [
            // 검색 설정
            IconButton(
              onPressed: () {
                // Search class로 신문기사 제목 데이터를 들고 이동
                showSearch(context: context, delegate: Search(titleList));
              },
              icon: const Icon(Icons.search),
            ),
            // 로그아웃 설정
            IconButton(
              onPressed: () {
                // 로그인 창으로 돌아가기
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.exit_to_app_sharp),
            )
          ],
        ),
        // Drawer를 이용해 사용자의 정보와 Section을 선택할 수 있는 SubMenu 설정
        drawer: const Drawer(child: SubMenu()),
        // 메인메뉴에 기사의 preview 보여주기
        body: ListView(
          itemExtent: 95,
          children:
              aInfos.map((info) => makeRowItem(context, info, "all")).toList(),
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

  // 메인 메뉴에서 뒤로가기 버튼을 눌렀을 때 경고창 띄우기
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('알람'),
            content: const Text('종료하시겠습니까?'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('아니오'),
              ),
              ElevatedButton(
                // 강제 종료
                onPressed: () => exit(0),
                child: const Text('네'),
              ),
            ],
          ),
        )
    ) ?? false;
  }
}

Widget makeRowItem(BuildContext ctx, ArticleInfo info, String s) {
  Image? img;
  // 만약 image data가 있을 때 Image.network를 사용해 data에 나와 있는 링크의 사진 보여주기
  // data가 없을 경우 제목과 내용 요약만 보이게 하려고 if문을 사용함
  if (info.image != "") {
    img = Image.network(
      info.image,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      width: MediaQuery.of(ctx).size.width * 0.3,
    );
  }

  return Center(
    child: Container(
      decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
      child: ListTile(
        isThreeLine: false,
        minLeadingWidth: 100,
        leading: img,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              alignment: Alignment.centerLeft,
              child: Text(
                info.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18.0),
                // 화면 상 문장이 1줄 이상일 때 끝을 ...으로 한 후 문장 자르기
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                info.article,
                style: const TextStyle(fontSize: 16.0),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        // 해당 타일을 눌렀을 경우 해당 기사의 데이터를 가지고 Article로 이동
        onTap: () {
          Navigator.push(
              ctx,
              MaterialPageRoute<void>(
                  builder: (_) => Article(info: info)));
        },
      ),
    ),
  );
}
