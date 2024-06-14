import 'package:flutter/material.dart';
import 'package:uas/accountpage/account_page.dart';
import 'package:uas/design/design.dart';
import 'package:uas/historypage/history_page.dart';
import 'package:uas/listdata/reviews_data.dart';
import 'package:uas/routes.dart';
import 'package:uas/searchpage/search_page.dart';
import 'package:uas/widgets/button.dart';
import 'package:uas/widgets/card.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController vidController;
  late Future<void> _initializeVideoPlayerFuture;
  bool videoError = false;

  @override
  void initState() {
    super.initState();
    vidController =
        VideoPlayerController.asset('assets/videos/placeholdervideo.mp4');
    _initializeVideoPlayerFuture = vidController.initialize().then((_) {
      vidController.play();
    }).catchError((error) {
      setState(() {
        videoError = true;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showIntroModal(context, vidController, _initializeVideoPlayerFuture);
    });
  }

  @override
  void dispose() {
    vidController.dispose();
    super.dispose();
  }

  void showIntroModal(BuildContext context, VideoPlayerController vidController,
      Future<void> initVidPlayerFuture) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        double heightFactor = videoError ? 0.7 : 0.5;

        return FractionallySizedBox(
          heightFactor: heightFactor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FutureBuilder(
                        future: initVidPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: vidController.value.aspectRatio,
                              child: VideoPlayer(vidController),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text("Video not found"),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: vidController,
                        builder: (context, VideoPlayerValue value, child) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (vidController.value.isPlaying) {
                                  vidController.pause();
                                } else {
                                  vidController.play();
                                }
                              });
                            },
                            child: vidController.value.isPlaying
                                ? Container()
                                : Icon(
                                    Icons.play_arrow,
                                    size: 64.0,
                                    color: white,
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                h(20),
                Text(
                  "A short video of all the places we have",
                  style: headerText(20),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: PrimaryBtn('Proceed'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeContent(),
    const SearchPage(),
    const HistoryPage(),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: 'Search',
            backgroundColor: black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: 'History',
            backgroundColor: black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'Profile',
            backgroundColor: black,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ticket & Food',
              style: appBar,
            ),
            Text(
              'Ordering',
              style: appBar,
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order',
              style: headerText(18),
            ),
            h(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OrderCard(
                  image: const AssetImage('assets/ticketIcon.png'),
                  label: 'Ticket',
                  onPressed: () {
                    navigateToOrderTicketPage(context);
                  },
                ),
                w(16),
                OrderCard(
                  image: const AssetImage('assets/foodIcon.png'),
                  label: 'Food',
                  onPressed: () {
                    navigateToOrderFoodPage(context);
                  },
                ),
              ],
            ),
            h(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'People’s Review',
                  style: headerText(18),
                ),
              ],
            ),
            h(10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: reviews
                      .map((review) => ReviewCard(review: review))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
