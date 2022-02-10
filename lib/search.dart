import 'package:flutter/material.dart';
import 'package:flutter_gms/article.dart';
import 'package:flutter_gms/main.dart';
import 'package:flutter_gms/menu/main_menu.dart';

// 검색 내역 리스트 선언
List<String> recentList = [];

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      // 검색창에 입력된 문자 제거 버튼
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // 뒤로가기 버튼
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    // 선택한 제목을 검색 내역에 포함
    int count = 0;
    for (int i = 0; i < aInfos.length; i++) {
      if (aInfos[i].title == selectedResult) {
        count = i;
        break;
      }
    }
    if (count == 0) {
      return const MyApp();
    }
    // 해당 기사로 이동
    return Article(info: aInfos[count]);
  }

  // 만들어진 검색 리스트 데이터를 가지고 검색창에 추가 기능 넣기
  final List<String> listExample;

  Search(this.listExample);

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList.addAll(listExample.where(
            (element) => element.contains(query),
          ));
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading:
              query.isEmpty ? const Icon(Icons.access_time) : const SizedBox(),
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
            selectedResult = suggestionList[index];
            recentList.insert(0, suggestionList[index]);
            showResults(context);
            buildResults(context);
          },
          trailing: query.isEmpty
              // 검색 내역 삭제 버튼
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    recentList.remove(suggestionList[index]);
                  },
                )
              : const SizedBox(),
        );
      },
    );
  }
}
