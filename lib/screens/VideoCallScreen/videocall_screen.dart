import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:toko_app_2/screens/products_overview_screen.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../widgets/custom_appbar.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  bool isResendAgain = false;

  double progress = 1.0;

  int start = 60 * 2;
  int oneMinute = (60 ~/ 60) % 60;

  DateTime now;
  Timer _timer;
  bool openState = true;
  String min = '00';
  String sec = '00';

  String get countText {
    Duration count = const Duration(seconds: 60);
    return controller.isDismissed
        ? '${min}:${sec}'
        : '${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _updateTime() {
    setState(
      () {
        now = DateTime.now();
        Duration count = const Duration(minutes: 1);
        // min = now.minute.toString().padLeft(2, '0');
        min = (count.inMinutes).toString().padLeft(2, '0');
        sec = now.second.toString().padLeft(2, '0');

        _timer = Timer(
          const Duration(seconds: 1) - Duration(milliseconds: now.millisecond),
          _updateTime,
        );
      },
    );
  }

  void _updateAnimation() {
    Timer.periodic(
      const Duration(milliseconds: 490),
      (v) {
        openState = !openState;
        // setState(
        //   () {
        //     openState = !openState;
        //   },
        // );
      },
    );
  }

  //--------------------
  // method waktu
  //--------------------
  waktu() {
    setState(() {
      isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (timer) {
      if (start == 0) {
        start = 60;
        isResendAgain = false;
        timer.cancel();
      } else {
        start++;
        oneMinute % 60;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _updateTime();
    _updateAnimation();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    controller.addListener(() {
      waktu();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/img/Yuriko hanabe.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: customAppBar(),
              top: 0,
              left: 0,
              right: 0,
            ),
            Positioned(
              top: 45,
              bottom: 0,
              left: 50,
              right: 0,
              child: Container(
                color: Colors.transparent,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 1,
                      child: AvatarGlow(
                        glowColor: Colors.white,
                        endRadius: 120,
                        duration: const Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        curve: Curves.easeOutQuad,
                        shape: BoxShape.rectangle,
                        child: Container(
                          height: 150, //SizeConfig.heightMultiplier * 19,
                          width: 150, //SizeConfig.widthMultiplier * 35,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/img/Kirana.jpg"),
                              fit: BoxFit.fill,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                      ),
                    ),
                    // Image.asset(
                    //   'assets/Tjalf Sparnaay.jpg',
                    //   height: 150,
                    //   width: 150,
                    // ),
                    Positioned(
                      bottom: 45,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: IconButton(
                                        icon: WebsafeSvg.asset(
                                            'assets/svg/flip.svg'),
                                        onPressed: () {})),
                                SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: IconButton(
                                        icon: WebsafeSvg.asset(
                                            'assets/svg/mic.svg'),
                                        onPressed: () {})),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 90),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: IconButton(
                                    icon:
                                        WebsafeSvg.asset('assets/svg/flip.svg'),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: IconButton(
                                      icon: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: WebsafeSvg.asset(
                                                'assets/svg/video.svg'),
                                          ),
                                          const Positioned(
                                            top: 7,
                                            left: 7,
                                            right: 7,
                                            bottom: 7,
                                            child: Icon(
                                              EvaIcons.videoOutline,
                                              color: Colors.white,
                                            ),
                                            // WebsafeSvg.asset(
                                            //     'assets/svg/video_camera.svg'),
                                          )
                                        ],
                                      ),
                                      onPressed: () {}),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 140),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      // Get.back();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ProductsOverviewScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height:
                                          50, //SizeConfig.heightMultiplier * 8,
                                      width:
                                          50, //SizeConfig.widthMultiplier * 14,
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(4, 8),
                                                color: Colors.black26,
                                                blurRadius: 8)
                                          ],
                                          shape: BoxShape.circle,
                                          color: Colors.purple),
                                      child: const Icon(
                                        Icons.call_end,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customAppBar() => CustomAppBar(
        color: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
            icon: WebsafeSvg.asset('assets/svg/arrow_left.svg'),
            onPressed: () {
              //Get.back();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProductsOverviewScreen();
                  },
                ),
              );
            }),
        title: Column(
          children: <Widget>[
            const Text(
              'Yuriko hanabe',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              '${countText.toString()}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              semanticsLabel: waktu(),
            ),
            // Text(
            //   '17:23',
            //   style: TextStyle(color: Colors.white, fontSize: 14),
            // ),
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: WebsafeSvg.asset('assets/svg/add.svg'), onPressed: () {}),
          IconButton(
              icon: WebsafeSvg.asset('assets/svg/message_circle.svg'),
              onPressed: () {}),
        ],
      );
}
