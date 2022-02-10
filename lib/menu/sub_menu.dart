import 'package:flutter/material.dart';

class Title {
  final String title;

  Title(this.title);
}

class SubMenu extends StatefulWidget {
  const SubMenu({Key? key}) : super(key: key);

  @override
  State<SubMenu> createState() => _SubMenuState();
}

class _SubMenuState extends State<SubMenu> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person), backgroundColor: Colors.white),
          otherAccountsPictures: [
            CircleAvatar(child: Icon(Icons.settings)),
          ],
          accountName: Text('이름'),
          accountEmail: Text('이메일'),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blueAccent, Colors.redAccent]),
          ),
        ),
        ExpansionTile(
          leading: const Icon(Icons.school),
          title: const Text('On Campus'),
          children: [
            ListTile(title: const Text("Brief"), onTap: () {}),
            ListTile(title: const Text("Campus Talk"), onTap: () {}),
            ListTile(title: const Text("Special Event"), onTap: () {}),
          ],
          trailing: const Icon(Icons.add),
        ),
        ExpansionTile(
          leading: const Icon(Icons.edit),
          title: const Text('Cover Story'),
          children: [
            ListTile(title: const Text("Editorial"), onTap: () {}),
            ListTile(title: const Text("Cover Story"), onTap: () {})
          ],
          trailing: const Icon(Icons.add),
        ),
        ExpansionTile(
          leading: const Icon(Icons.font_download_outlined),
          title: const Text('English Clinic'),
          children: [
            ListTile(title: const Text("English Expert Column"), onTap: () {}),
            ListTile(title: const Text("Writing Clinic"), onTap: () {}),
            ListTile(title: const Text("Reading Clinic"), onTap: () {}),
            ListTile(title: const Text("English Study Web site"), onTap: () {}),
            ListTile(title: const Text("Q&A Column"), onTap: () {})
          ],
          trailing: const Icon(Icons.add),
        ),
        ExpansionTile(
          leading: const Icon(Icons.flight_outlined),
          title: const Text('Global Campus'),
          children: [
            ListTile(title: const Text("Info Exchange Univ"), onTap: () {}),
            ListTile(title: const Text("Faculty Column"), onTap: () {}),
            ListTile(title: const Text("Student Column"), onTap: () {}),
            ListTile(title: const Text("Foreign Student Column"), onTap: () {}),
            ListTile(title: const Text("Episode Column"), onTap: () {})
          ],
          trailing: const Icon(Icons.add),
        ),
        ExpansionTile(
          leading: const Icon(Icons.voicemail),
          title: const Text('Society'),
          children: [
            ListTile(title: const Text("Interview"), onTap: () {}),
            ListTile(title: const Text("Gachonian"), onTap: () {}),
            ListTile(title: const Text("Campus tour"), onTap: () {})
          ],
          trailing: const Icon(Icons.add),
        ),
        ExpansionTile(
          leading: const Icon(Icons.sports_soccer),
          title: const Text('Culture'),
          children: [
            ListTile(title: const Text("Experience"), onTap: () {}),
            ListTile(title: const Text("Movie"), onTap: () {}),
            ListTile(title: const Text("Drama"), onTap: () {}),
            ListTile(title: const Text("Book"), onTap: () {}),
            ListTile(title: const Text("Stage&Music"), onTap: () {}),
            ListTile(title: const Text("Leisure&Health"), onTap: () {}),
            ListTile(title: const Text("Photo Essay"), onTap: () {})
          ],
          trailing: const Icon(Icons.add),
        ),
        ExpansionTile(
          leading: const Icon(Icons.home),
          title: const Text('About'),
          children: [
            ListTile(title: const Text("The Gachon Herald"), onTap: () {}),
            ListTile(title: const Text("Reporters"), onTap: () {}),
            ListTile(title: const Text("Quiz"), onTap: () {})
          ],
          trailing: const Icon(Icons.add),
        ),
      ],
    );
  }
}

var session = {
  'brief': ['dr', 'ar']
};
