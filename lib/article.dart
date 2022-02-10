import 'package:flutter/material.dart';
import 'package:flutter_gms/article_info.dart';
import 'package:flutter_gms/setting.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Article extends StatefulWidget {
  const Article({Key? key, required this.info}) : super(key: key);
  final ArticleInfo info;

  @override
  _ArticleState createState() => _ArticleState();
}

String? articlefontfamily = 'arial';
double? articletextspace = 1.0;
double? articletextsize = 30.0;
Color? articletextcolor = Colors.black87;
Color? articlebackgroundcolor = Colors.white;

class _ArticleState extends State<Article> {

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
          overflow: TextOverflow.fade,
          style:
              const TextStyle(fontFamily: 'arial', fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const Setting()));
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // title
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
            // subTitle
            Container(
              color: articlebackgroundcolor,
              child: st,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            ),
            // reporter & email
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
            // date & time
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
            // image & article
            Container(
              color: articlebackgroundcolor,
              child: Column(
                children: [
                  Container(
                      child: img,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20)),
                  Container(
                      margin: const EdgeInsets.all(20.0),
                      child: SelectableText(
                        widget.info.article,
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
