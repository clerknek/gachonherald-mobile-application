import 'package:flutter/material.dart';
import 'package:flutter_gms/article_info.dart';
import 'package:flutter_gms/setting.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Article extends StatefulWidget {
  // 선택한 기사의 정보가 필요하기 때문에 input에 required this.info 추가
  const Article({Key? key, required this.info}) : super(key: key);
  final ArticleInfo info;

  @override
  _ArticleState createState() => _ArticleState();
}

// 기본 기사 스타일 지정
String? articlefontfamily = 'arial';
double? articletextspace = 1.0;
double? articletextsize = 30.0;
Color? articletextcolor = Colors.black87;
Color? articlebackgroundcolor = Colors.white;

class _ArticleState extends State<Article> {
  // 기사 TTS 세팅
  final FlutterTts tts = FlutterTts();
  _ArticleState() {
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
  }
  int ai = 0;
  var speech;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 기사의 부제목이 없을 경우를 대비
    var st;
    if (widget.info.subTitle != "") {
      st = Center(
        child: Text(
          widget.info.subTitle,
          style: TextStyle(
            color: articletextcolor,
            fontSize: 20.0,
          ),
        ),
      );
    }

    // 기사의 사진이 없을 경우를 대비
    var img;
    if (widget.info.image != "") {
      img = Image.network(
        widget.info.image,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.8,
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.info.title,
          // 텍스트가 지정된 공간을 넘었을 시 뿌옇게 변하면서 텍스트 자르기
          overflow: TextOverflow.fade,
          style:
              const TextStyle(fontFamily: 'arial', fontWeight: FontWeight.bold),
        ),
        actions: [
          // 기사 스타일 설정 아이콘 추가
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const Setting()));
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // 기사 제목
            Container(
              color: articlebackgroundcolor,
              child: Center(
                child: SelectableText(
                  widget.info.title,
                  style: TextStyle(
                      fontSize: 30.0,
                      color: articletextcolor,
                      fontFamily: articlefontfamily,
                      fontWeight: FontWeight.bold),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            ),
            // 기사 부제목
            Container(
              color: articlebackgroundcolor,
              child: st,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            ),
            // 기자 이름 & 이메일 주소
            Container(
                color: Colors.grey[300],
                child: Row(children: [
                  const Expanded(child: Text('')),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${widget.info.reporter}  |  ${widget.info.email}  ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black87,
                          fontFamily: 'arial'),
                    ),
                  ),
                ])),
            // 기사 쓴 날짜 & 시간
            Container(
              color: Colors.grey[300],
              child: Row(
                children: [
                  const Expanded(child: Text('')),
                  Container(
                    margin: const EdgeInsets.only(right: 5.0),
                    child: Text(
                      "updated: ${widget.info.date} ${widget.info.time} ",
                      style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.black87,
                          fontFamily: 'arial'),
                    ),
                  ),
                ],
              ),
            ),
            // 기사 사진 & 내용
            Container(
              color: articlebackgroundcolor,
              child: Column(
                children: [
                  Container(
                      child: img,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20)),
                  Container(
                      margin: const EdgeInsets.all(20.0),
                      // 기사 내용 중에서 선택된 부분을 TTS를 하는 기능을 만들고 싶었기 때문에 Container 대신 선택 가능한 SelectableText를 사용
                      child: SelectableText(
                        widget.info.article,
                        // 기사 스타일을 설정에서 변경하면 기사 위젯에서도 같이 변경되어야 하기 때문에 처음 선언했던 값으로 지정
                        style: TextStyle(fontFamily: articlefontfamily, fontSize: articletextsize, height: articletextspace, color: articletextcolor),
                        onSelectionChanged: (selections, cause) {
                          speech = widget.info.article
                              .substring(selections.start, selections.end);
                        },
                      )),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Row(children: [
        const SizedBox(
          width: 10,
        ),
        // TTS 재생 버튼
        ElevatedButton(
            onPressed: () {
              if (speech == null) {
                tts.speak(widget.info.article);
              } else {
                tts.speak(speech);
              }
            },
            child: const Icon(Icons.play_arrow)),
        const SizedBox(
          width: 5,
        ),
        // TTS 종료 버튼
        ElevatedButton(
            onPressed: () {
              tts.stop();
            },
            child: const Icon(Icons.stop)),
        const SizedBox(
          width: 10,
        ),
      ],),
    );
  }
}
