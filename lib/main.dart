import 'package:flutter/material.dart';
import 'package:uas/landingpage/onboarding_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(
        pages: [
          OnboardingPageModel(
            title: 'SD-H USAI',
            description:
                '- Jafier Andreas (535220013)\n- Nelson (535220021)\n- Jessen Chayadi (535220023)\n- Finnia Li (535220030)\n- Timoty W. P. (535220043)',
            image: 'assets/lp-1.png',
            bgColor: Colors.indigo,
          ),
          OnboardingPageModel(
            title: 'Lorem Ipsum Dolor',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
            image: 'assets/image1.png',
            bgColor: const Color(0xff1eb090),
          ),
          OnboardingPageModel(
            title: 'Lorem Ipsum Dolor Sit Amet',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            image: 'assets/image2.png',
            bgColor: const Color(0xfffeae4f),
          ),
          OnboardingPageModel(
            title: 'Lorem Ipsum Dolor',
            description: 'Get Started Now!',
            image: 'assets/image3.png',
            bgColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
