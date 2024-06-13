import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/zone_data.dart';
import 'package:uas/routes.dart';
import 'package:uas/widgets/button.dart';
import 'package:uas/widgets/grid.dart';
import 'package:video_player/video_player.dart';

class ChooseZonePage extends StatefulWidget {
  const ChooseZonePage({super.key});

  @override
  State<ChooseZonePage> createState() => _ChooseZonePageState();
}

class _ChooseZonePageState extends State<ChooseZonePage> {
  late VideoPlayerController vidController;
  late Future<void> _initializeVideoPlayerFuture;
  bool videoError = false;

  @override
  void initState() {
    super.initState();
    vidController =
        VideoPlayerController.asset('assets/videos/placeholdervideo.mp4');
    _initializeVideoPlayerFuture =
        vidController.initialize().catchError((error) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateToHomePage(context);
          },
        ),
        title: Text(
          "Choose Zone",
          style: appBar,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: warningBox,
                child: Column(
                  children: [
                    Text("Warning!!!", style: warningText),
                    Text(
                      "Make sure you are in the right zone before ordering",
                      style: TextStyle(
                        color: black,
                      ),
                    ),
                  ],
                ),
              ),
              h(20),
              Text(
                "Zone List",
                style: headerText(24),
              ),
              h(20),
              Expanded(child: buildZoneGrid(context, zoneData)),
            ],
          ),
        ),
      ),
    );
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
}
