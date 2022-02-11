# Gachon Herald Mobile Service
<img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white"/> <img src="https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white"/>

![image](https://user-images.githubusercontent.com/71575861/153518862-748a5761-989b-46e2-8860-bbdfa3edcb52.png)


> ## 목적
> - 대학생들의 영자신문 접근성 강화
> - 독자들의 쉬운 피드백

> ## 코드
>> ### 0. 초기 main 설정
>>>> - 스마트폰 다크모드 선택에 따라 테마가 면하도록 *darkTheme:* 를 포함했다
>>>> - menu 폴더를 만든 후 **main_menu.dart**를 만든다.
>>>> 
>>>> ![image](https://user-images.githubusercontent.com/71575861/153521753-7c3572df-38d2-4a96-b1a7-93e88110c592.png)

>> ### 1. main menu
>>> + WillPopScope
>>>> - 스마트폰상 뒤로 가기 버튼을 누를 때 종료 여부를 물어보는 창을 띄우기 위해 ***Scaffold()*** 를 ***WillPopScope()*** 로 감쌌다
>>>> - 앱을 종료할 때는 flutter 내에 저장되어 있는 **service.dart**를 import 한 후 ***SystemNavigation.pop()*** 을 사용하면 된다.
>>>> 
>>>> ![image](https://user-images.githubusercontent.com/71575861/153521713-03f8e2c3-7c0d-44c1-b193-cf095e39977e.png)

>>>> - ***WillPopScope()*** 의 *child:* 로 들어가 있는 ***Scaffold()*** 에서는 상단 바인 ***Appbar()***, 서브 메뉴를 열 수 있는 ***Drawer()***, 그리고 본문에는 기사 리스트를 보이게 하기 위해 ***ListView()*** 를 사용할 것이기 때문에 각각 *appBar:*, *drawer:*, *body:* 요소에 추가해준다.
>>>> - ***Appbar()*** 에는 타이틀 명과 ***IconButton()*** 을 추가한다
>>>> 
>>>> ![image](https://user-images.githubusercontent.com/71575861/153521823-30622034-e1dc-4673-931c-0742ba245f35.png)


>>> + ListTile
>>>> - 기사 리스트를 보여주기에 앞서 샘플 데이터를 저장한다.
>>>> - data 폴더를 만든 후 그 안에 **article_data.dart**파일을 생성한다.
>>>> - 다음은 그 안에 있는 데이터와 데이터에 대한 설명이다.
>>>> - 전부 var 타입이며 리스트 형식으로 이루어져 있다.
>>>> 
>>>> 데이터 명 | 데이터 설명 | 데이터 예시
>>>> ---- | ---- | ----
>>>> functionList | 기사의 섹션 | ["Book"] 
>>>> titleList | 기사 제목 | ["Big Brother is Watching You"]
>>>> subTitleList | 기사 부제목 | ["1984, the prophecy of George Orwell"]
>>>> reporterList | 기사를 쓴 기자 이름 | ["Jeon Jong-Min"]
>>>> emailList | 기사를 쓴 기자 이메일 | ["jongmin1701@naver.com"]
>>>> dateList | 기사 쓴 날짜 | ["2019.09.21"]
>>>> timeList | 기사 쓴 시간 | ["18:00:48"]
>>>> articleList | 기사 내용 | ["In June, there was a news story about an internet lecturer fabricating comments…"]
>>>> imageList | 기사에 포함된 사진(url형식) | ['http://www.gachonherald.com/news/photo/201909/803_2691_349.jpeg']

>>>> - redirecting constructor를 통해 ArticleInfo class를 만든다.
>>>> - for 구문과 ArticleInfo를 이용해 **article_data.dart** 에서 데이터를 불러와 List 형식으로 만든다.



>> ### 2. sub menu
>> 
>>> + DrawerHeader
>>> + ExpansionTile
>> ### 3. Firebase
>>> + Firebase
>>> + Cloud Messaging
>>> + Authentication
>> ### 4. article
>>> + Article
>>> + TTS
>>> + Setting
>> ### 5. Search
> ## 부족한 점
> 
---------------------------------------------------------
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
