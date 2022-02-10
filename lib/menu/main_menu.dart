import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search(titleList));
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.exit_to_app_sharp),
            )
          ],
        ),
        drawer: const Drawer(child: SubMenu()),
        body: ListView(
          itemExtent: 95,
          children:
              aInfos.map((info) => makeRowItem(context, info, "all")).toList(),
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

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
                onPressed: () => SystemNavigator.pop(animated: true),
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
