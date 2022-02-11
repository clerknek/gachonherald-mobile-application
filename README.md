# Gachon Herald Mobile Service
![image](https://user-images.githubusercontent.com/71575861/153518862-748a5761-989b-46e2-8860-bbdfa3edcb52.png)


> ## 목적
> - 대학생들의 영자신문 접근성 강화
> - 독자들의 쉬운 피드백

> ## 코드
>> ### 0. 초기 main 설정
>>>> - 스마트폰 다크모드 선택에 따라 테마가 면하도록 darkTheme: 를 포함했다
>>>> - menu 폴더를 만든 후 main_menu.dart를 만든다.
>>>> ![image](https://user-images.githubusercontent.com/71575861/153519188-9a60e186-9f0e-4fd5-9afb-eeecc68d41a7.png)

>> ### 1. main menu
>>> + WillPopScope
>>>> 스마트폰상 뒤로 가기 버튼을 누를 때 종료 여부를 물어보는 창을 띄우기 위해 Scaffold를 <span style="color:blue">WillPopScope()</span>로 감쌌다
>>> + ListTile
>> ### 2. sub menu

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

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
