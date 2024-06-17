import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/member_data.dart';
import 'package:uas/widgets/card.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPage();
}

class _AboutUsPage extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: appBar,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/aboutus/kelompok.png'),
            ),
            h(16.0),
            Text(
              'SD-H USAI',
              style: headerText(24),
            ),
            h(16.0),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return MemberCard(member: members[index]);
                },
              ),
            ),
            h(16.0),
            Text(
              'Copyright © 2024 SD-H USAI',
              style: copyrightText,
            ),
          ],
        ),
      ),
    );
  }
}
