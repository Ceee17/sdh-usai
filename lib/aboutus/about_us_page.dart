import 'package:flutter/material.dart';
import 'package:uas/accountpage/account_page.dart';
import 'package:uas/homepage/home_page.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPage();
}

class _AboutUsPage extends State<AboutUsPage> {
  final List<Member> members = [
    Member(
        name: 'Jafier Andreas',
        id: '535220013',
        initials: 'JA',
        qrCodePath: 'assets/qrmember/linkjafier.png',
        link: 'Discord : https://s.id/26VYj'),
    Member(
        name: 'Nelson',
        id: '535220021',
        initials: 'NL',
        qrCodePath: 'assets/qrmember/linknelson.png',
        link: 'Instagram : https://s.id/26VY9'),
    Member(
        name: 'Jessen Chayadi',
        id: '535220023',
        initials: 'JC',
        qrCodePath: 'assets/qrmember/linkjc.png',
        link: 'LinkedIn : https://s.id/26VY8'),
    Member(
        name: 'Finnia Li',
        id: '535220030',
        initials: 'FL',
        qrCodePath: 'assets/qrmember/linkfinnia.png',
        link: 'Instagram : https://s.id/26VYm'),
    Member(
        name: 'Timoty Wahyudi P',
        id: '535220043',
        initials: 'TP',
        qrCodePath: 'assets/qrmember/linktimot.png',
        link: 'WhatsApp : https://s.id/26VYe'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AccountPage(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/aboutus/kelompok.png'),
            ),
            SizedBox(height: 16.0),
            Text(
              'SD-H USAI',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return MemberTile(member: members[index]);
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Copyright © 2024 SD-H USAI',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class Member {
  final String name;
  final String id;
  final String initials;
  final String qrCodePath;
  final String link;

  Member({
    required this.name,
    required this.id,
    required this.initials,
    required this.qrCodePath,
    required this.link,
  });
}

class MemberTile extends StatelessWidget {
  final Member member;

  const MemberTile({required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(member.name),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(member.qrCodePath),
                    SizedBox(height: 16),
                    Text(member.link),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text(
              member.initials,
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(member.name),
          subtitle: Text(member.id),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AboutUsPage(),
  ));
}
