import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toko_app_2/screens/VideoCallScreen/videocall_screen.dart';

import '../../utils/sized_config.dart';
import 'Components/profile_pic_widget.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 25, // SizeConfig.heightMultiplier * 3,
            ),
            const Text(
              "Hallo, \n Anda sedang berbicara dengan Kirana",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, //SizeConfig.textMultiplier * 2.5,
                color: Colors.purple,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 75, //SizeConfig.heightMultiplier * 10,
            ),
            // getar dering
            Container(
              height: MediaQuery.of(context).size.height /
                  3.5, //SizeConfig.heightMultiplier * 30,
              width: 250, //SizeConfig.widthMultiplier * 100,
              child: const ProfilePicWidget(),
            ),
            const SizedBox(
              height: 30, //SizeConfig.heightMultiplier * 2,
            ),
            const Text(
              "Kirana",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 19, //SizeConfig.textMultiplier * 2.5,
                  color: Colors.purple,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 25, // SizeConfig.heightMultiplier * 2,
            ),
            const Text(
              "Berdering...",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 150, //SizeConfig.heightMultiplier * 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol tutup telpon
                GestureDetector(
                  onTap: () {
                    // Get.back();
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return;
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 60, // SizeConfig.heightMultiplier * 8,
                    width: 60, //SizeConfig.widthMultiplier * 18,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: Offset(4, 8),
                          color: Colors.black26,
                          blurRadius: 8)
                    ], shape: BoxShape.circle, color: Colors.purple),
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 35, // SizeConfig.widthMultiplier * 5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.back();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const VideoCallScreen();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 60, //SizeConfig.heightMultiplier * 8,
                    width: 60, //SizeConfig.widthMultiplier * 18,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: Offset(4, 8),
                          color: Colors.black26,
                          blurRadius: 8)
                    ], shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      EvaIcons.videoOutline,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 0 * .15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
