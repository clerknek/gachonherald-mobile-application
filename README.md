# Gachon Herald Mobile Service
<img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white"/> <img src="https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white"/>

![image](https://user-images.githubusercontent.com/71575861/153518862-748a5761-989b-46e2-8860-bbdfa3edcb52.png)

> # 목차
> #### - 목적
>> #### [0. 초기 main 설정 ](#0-초기-main-설정)
>> #### [1. main menu ](#1-main-menu)
>>> #### [1.1. WillPopScope ](#11-willpopscope)
>>> #### [1.2. ListTile ](#12-listtile)
>> #### [2. sub menu ](#2-sub-menu)
>>> #### [2.1. DrawerHeader ](#21-drawerheader)
>>> #### [2.2. ExpansionTile ](#22-expansiontile)
>> #### [3. Firebase ](#3-firebase)
>>> #### [3.1. Firebase ](#31-firebase)
>>> #### [3.2. Cloud Messaging ](#32-cloud-messaging)
>>> #### [3.3. Authentication ](#33-authentication)
>> #### [4. article ](#4-article)
>>> #### [4.1. Article ](#41-article)
>>> #### [4.2. TTS ](#42-tts)
>>> #### [4.3. Setting ](#43-setting)
>> #### [5. Search ](#5-search)
> #### - 부족한 점

-----------------------------------------------------

> ## 목적
> - 대학생들의 영자신문 접근성 강화
> - 독자들의 쉬운 피드백

> ## 코드
>> ### 0. 초기 main 설정
>>> - main.dart
>>>> - 스마트폰 다크모드 선택에 따라 테마가 면하도록 *darkTheme:* 를 포함했다.
>>>> - menu 폴더를 만든 후 **main_menu.dart**를 만든다.


>> ### 1. main menu
>>> ### 1.1. WillPopScope
>>>> - #### main_menu.dart
>>>> - 스마트폰상 뒤로 가기 버튼을 누를 때 종료 여부를 물어보는 창을 띄우기 위해 ***Scaffold()*** 를 ***WillPopScope()*** 로 감쌌다.
>>>> - 앱을 종료할 때는 flutter 내에 저장되어 있는 **service.dart**를 import 한 후 ***SystemNavigation.pop()*** 을 사용하면 된다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153521713-03f8e2c3-7c0d-44c1-b193-cf095e39977e.png)
>>>>
>>>> - ***WillPopScope()*** 의 *child:* 로 들어가 있는 ***Scaffold()*** 에서는 상단 바인 ***Appbar()***, 서브 메뉴를 열 수 있는 ***Drawer()***, 그리고 본문에는 기사 리스트를 보이게 하기 위해 ***ListView()*** 를 사용할 것이기 때문에 각각 *appBar:*, *drawer:*, *body:* 요소에 추가해준다.
>>>> - ***Appbar()*** 에는 타이틀 명과 ***IconButton()*** 을 추가한다. 
>>>> ![image](https://user-images.githubusercontent.com/71575861/153521823-30622034-e1dc-4673-931c-0742ba245f35.png)

>>> ### 1.2. ListTile
>>>> - #### article_data.dart
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

>>>> - #### article_info.dart
>>>> - redirecting constructor를 통해 ArticleInfo class를 만든다.
>>>> - for 구문과 ArticleInfo를 이용해 **article_data.dart** 에서 데이터를 불러와 List 형식으로 만든다.

>>>> - #### main_menu.dart
>>>> - ***makeRowItem()*** 을 생성한 후 리스트 칸에 들어갈 내용과 디자인 코드를 적는다.
>>>> - 리스트의 내용에는 *overflow:* 를 이용해서 텍스트가 특정 줄 수를 넘어가지 않도록 한다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153525122-905055a1-b28a-445b-9dd6-bfb8cf36261b.png)
>>>>
>>>> - **article_info.dart** 에서 데이터를 불러오기 위해 class 밖에서 aInfos를 선언한다.
>>>> - ***ListView()*** 에 데이터를 넣는다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153525353-af2d84d8-c7fb-40ad-beb8-b722bb5e9ec1.png)
>>>>
>>>> - 타일 앞쪽에 ***Image.network()*** 를 이용해 사진을 넣어준다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153525447-53e7eb81-eb6a-4e42-b8cb-03ac8c3b5cd7.png)
>>>>
>>>> - url에서 이미지를 가지고 올 경우 chrome 디바이스에서는 이미지가 안보인다.
>>>> - 이 경우 터미널에 들어가 'flutter run -d chrome --web-renderer html'을 입력해서 실행하면 해결이 된다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153528259-4c2f110a-2bd0-4f8f-ac15-4dbcd5b0e54e.png)


>> ### 2. sub menu 
>>> ### 2.1. DrawerHeader
>>>> - #### sub_menu.dart
>>>> - 사용자의 정보가 나와있는 탭을 보여주기 위해 ***UserAccountsDrawerHeader()*** 를 이용한다.
>>>> - ***CircleAvatar()*** 를 통해 원형 탭을 만들어 주고 ***LinearGradient()*** 를 통해 그라데이션을 준다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153528603-46be7568-79ce-4ff9-990c-e1ae5d35d54a.png)

>>> ### 2.2. ExpansionTile
>>>> - Header 아래에 작은 색션을 ***ListTile()*** 를 이용해 나열한다.
>>>> - 큰 섹션을 만들기 위해 사용자의 터치로 확장이 가능한 타일인 ***ExpansionTile()*** 을 이용해 만든다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153528796-da1f8349-d08e-4c37-b907-dcb7ef72bcf2.png)

>> ### 3. Firebase
>>> ### 3.1. Firebase
>>>> - 대부분의 서버 기능들을 실제 서버 구성없이 배포가 가능한 수준으로 만들 수 있도록 도와주는 백엔드 서비스이다.
>>>> - 짧은 시간 안에 백엔드 아키텍처를 구성하고 사용할 수 있도록 도와준다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153529156-2b297c80-9365-4138-9ea0-508d14a77ec6.png)

>>>> ### - 연동하기
>>>> ① https://console.firebase.google.com/u/0/ 로 이동하여 프로젝트 추가를 누른 후 프로젝트 이름과 기초 설정을 선택한 후 프로젝트를 생성한다.   
>>>> ![ezgif com-gif-maker](https://user-images.githubusercontent.com/71575861/153532454-65b94e0d-b0f6-4fd9-9922-3267eca2896b.gif)
>>>> 
>>>> ② 안드로이드 버튼을 누른다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153532733-48d4d17d-b2e9-4d14-a6ee-77b866e3628d.png)
>>>> 
>>>> ③ 원하는 플러터 프로젝트 패키지 이름을 android > app > build.gradle에 들어가 찾은 후 입력한다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153532574-fa3b81c5-bf9b-4903-8403-e37c06580aa4.png)
>>>> 
>>>> ④ google-service.json을 다운로드 한 후 android > app 폴더에 붙여넣기 한다. (이때 파일 이름 ’google-service.json’ 이 정확하게 들어가야 함)
>>>> ![image](https://user-images.githubusercontent.com/71575861/153532606-9cedc725-2657-4c78-aaf1-d7bf0402ff5c.png)
>>>> 
>>>> ⑤ android > build.gradle에 코드 추가
>>>> ![image](https://user-images.githubusercontent.com/71575861/153532810-3be93025-a13d-46ad-9550-c7395f4b67da.png)
>>>> 
>>>> ⑥ android > app > build.gradle에 코드 추가 후 다음 2번 누르면 연동 끝
>>>> ![image](https://user-images.githubusercontent.com/71575861/153532837-42e3b798-072b-4d9f-96c7-63c7fd5c6829.png)

>>>> ### - android > app > build.gradle 에러 없애기
>>>> - 사실 저 에러를 없애지 않아도 앱은 돌아가긴 하지만 보기 싫다면 해결하는 방법이 있다.
>>>> - 문제가 발생하는 이유는 SDK가 설정이 되어 있지 않아 생기는 오류이다.
>>>> 
>>>> ① 상단 바에서 File > Project Structure…에 들어간다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153533625-c716d025-7f24-4c85-bb7e-bb206323df00.png)
>>>> 
>>>> ② Project Setting > Modules > 프로젝트 명 > Dependencies에 들어가 Module SDK를 설정해주고 OK를 누른다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153533744-f35a4d4f-58a0-44e8-ab71-1ebeb69f4a0a.png)
>>>> 
>>>> ③ API 29부터 대체된 GradleException을 FileNotFoundException으로 바꾸면 에러가 사라진다
>>>> ![image](https://user-images.githubusercontent.com/71575861/153533704-2f31a0fe-2078-4a87-b032-f3e2567dc2c0.png)

>>>> ### - Firebase 패키지 모음 사이트
>>>> - https://firebase.flutter.dev/ 에 들어가면 Firebase를 사용 할 때 필요한 flutter 패키지와 그 설명서 링크가 있다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153534405-610104af-ed0d-4cb6-8223-4741e861fe74.png)

>>> ### 3.2. Cloud Messaging
>>>> - Firebase를 통해 앱 이용자에게 알람을 보낼 수 있는 기능을 구현할 수 있다.
>>>> - 필요한 패키지
>>>>> - firebase_core: https://pub.dev/packages/firebase_core
>>>>> - firebase_messaging: https://pub.dev/packages/firebase_messaging 
>>>> - firebase_core와 firebase_messaging 그리고 나중에 필요한 FCM 등록 토큰을 print하기 위해 **foundation.dart**을 import 해준다.
>>>> 
>>>> - #### main.dart
>>>> - MyApp에서 return 해주는 *home:* 값을 새로 만든 ***Messaging()*** 으로 바꾼다.
>>>> - ***Messaging()*** 내용 채우기
>>>> ![image](https://user-images.githubusercontent.com/71575861/153538651-b67b10f7-4505-4d9b-b6f3-42b8b96281f8.png)
>>>> 
>>>> - FCM 토큰 확인하기
>>>> ![image](https://user-images.githubusercontent.com/71575861/153536292-c13b8c7a-8dfa-4866-aefe-ad1ea43ab364.png)
>>>> 
>>>> - 만약 토큰 출력이 안된다면 android > app > build.gradle에 가서 minSdkVersion을 23, targetSdkVersion을 30으로 바꾼 후 다시 출력
>>>> ![image](https://user-images.githubusercontent.com/71575861/153536317-6c86d444-5ea6-44ae-b956-796bbe41f6ff.png)
>>>> 
>>>> - Firebase 콘솔에서 ‘참여 > Cloud Messaging’에 들어가 ‘Send your first message’ 버튼을 누른다
>>>> ![image](https://user-images.githubusercontent.com/71575861/153536368-3e08c011-4bba-4abc-ad76-6d357dcd1439.png)
>>>> 
>>>> - 알림 제목과 알림 텍스트에 원하는 내용을 입력하고 ‘테스트 메시지 전송’ 버튼을 누른다
>>>> ![image](https://user-images.githubusercontent.com/71575861/153536392-b299f265-1d00-41cd-afc2-18bee58d3957.png)
>>>> 
>>>> - 프로젝트에서 출력했던 FCM 등록 토큰을 추가한다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153536426-de382662-d3f8-4549-b868-437f6fd6864a.png)
>>>> 
>>>> - 테스트 메시지 출력되는 것을 확인
>>>> ![image](https://user-images.githubusercontent.com/71575861/153536468-f236f67a-00ab-4b94-aba9-46d92d85f15f.png)

>>> ### 3.3. Authentication
>>>> - Firebase에서 Authentication을 이용하면 로그인 화면을 만들 수 있을 뿐만 아니라 Google, Facebook 등 다양한 추가 제공업체의 로그인 방법을 추가할 수 있다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153538380-89ce8d1f-5dd8-4b63-92bb-f0963dcb7f3d.png)
>>>> - 필요한 패키지
>>>>> - firebase_auth: https://pub.dev/packages/firebase_auth
>>>>> - flutterfire_ui: https://pub.dev/packages/flutterfire_ui
>>>> - #### main.dart
>>>> - **main.dart**를 수정한다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153538726-018e8b1c-c908-4dcd-b955-3f1b4efa3696.png)
>>>> 
>>>> - #### main_menu.dart
>>>> - 로그아웃 버튼을 수정한다
>>>> ![image](https://user-images.githubusercontent.com/71575861/153538776-e20cfeca-f377-4c3e-b554-f5af12a0327f.png)

>>>> ### - Firebase Authentication와 연결
>>>> - Firebase에서 Authentication을 누른 후 Sign-in method에 들어가 원하는 로그인 하는 방법을 추가한다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153538893-97ffc478-50b1-4470-b7dc-9556d45d9e16.png)
>>>> 
>>>> - 이메일/비밀번호 사용 설정 후 저장한다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153538949-66d86ace-5d9f-46f0-aee7-8eed319d73d9.png)
>>>> 
>>>> - Users 탭에 들어가면 Firebase에서 직접 사용자를 추가하거나 모바일 앱에서 register 버튼을 눌러 추가할 수 있다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153538968-10d6f6d0-0736-490e-8015-6f6be808edfd.png)











>> ### 4. article
>>> ### 4.1. Article
>>> ### 4.2. TTS
>>> ### 4.3. Setting
>> ### 5. Search
> ## 부족한 점


---------------------------------------------------------
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
