import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPage();
}

class _AboutUsPage extends State<AboutUsPage> {
  final List<Member> members = [
    Member(name: 'Jafier Andreas', id: '535220013', initials: 'JA'),
    Member(name: 'Nelson', id: '535220021', initials: 'NL'),
    Member(name: 'Jessen Chayadi', id: '535220023', initials: 'JC'),
    Member(name: 'Finnia Li', id: '535220030', initials: 'FL'),
    Member(name: 'Timoty Wahyudi P', id: '535220043', initials: 'TP'),
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
          onPressed: () {},
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

  Member({required this.name, required this.id, required this.initials});
}

class MemberTile extends StatelessWidget {
  final Member member;

  const MemberTile({required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
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
    );
  }
}
