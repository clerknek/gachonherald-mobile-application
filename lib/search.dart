import 'package:flutter/material.dart';
import 'package:flutter_gms/article.dart';
import 'package:flutter_gms/main.dart';
import 'package:flutter_gms/menu/main_menu.dart';

List<String> recentList = ["Text 4", "Text 3"];


class Search extends SearchDelegate {


  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  // 문자 제거 버튼

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  // 뒤로가기 버튼

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    int count = 0;
    for (int i = 0; i < aInfos.length; i++){
      if (aInfos[i].title == selectedResult){
        count = i;
        break;
      }
    }
    if(count == 0){
      return const MyApp();
    }

    return Article(info: aInfos[count]);
  }

  // 결과창

  final List<String> listExample;

  Search(this.listExample);

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];

    query.isEmpty
        ? suggestionList = recentList //In the true case

        : suggestionList.addAll(listExample.where(
            // In the false case

            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? const Icon(Icons.access_time) : const SizedBox(),
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
            selectedResult = suggestionList[index];
            recentList.insert(0, suggestionList[index]);
            showResults(context);
            buildResults(context);
          },
          trailing: query.isEmpty
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
// 검색 내역
}
