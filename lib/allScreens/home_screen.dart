import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openvpn_test_app/allControllers/home_controller.dart';
import 'package:openvpn_test_app/allWidgets/custom_widget.dart';
import 'package:openvpn_test_app/appPreferences/appPreferences.dart';

import '../main.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  locationSelectionBottomNavigation(BuildContext context) {
    return SafeArea(
        child: Semantics(
      button: true,
      child: InkWell(
        onTap: () {},
        child: Container(
          color: Colors.redAccent,
          padding: EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.041),
          height: 62,
          child: const Row(
            children: [
              Icon(
                CupertinoIcons.flag_circle,
                size: 36,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "Select Country / Location",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              Spacer(),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.keyboard_arrow_right),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget vpnRoundButton() {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.pink,
                ),
                child: Container(
                  width: sizeScreen.width * 0.14,
                  height: sizeScreen.height * 0.14,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 30,
                        // color: Colors.white,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Tap to connect",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onTap: () {},
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    sizeScreen = Get.size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Free VPN'),
        leading: IconButton(
          icon: Icon(Icons.perm_device_info),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_2_outlined),
            onPressed: () {
              Get.changeThemeMode(
                  AppPreferences.isModeDark ? ThemeMode.light : ThemeMode.dark);
              AppPreferences.isModeDark = !AppPreferences.isModeDark;
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //2 round widget
          //location + ping
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidget(
                titleText: homeController.vpnInfo.value.contryLongName.isEmpty
                    ? "Location"
                    : homeController.vpnInfo.value.contryLongName,
                subTitleText: "FREE",
                roundWidgetWithIcon: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.redAccent,
                  child: homeController.vpnInfo.value.contryLongName.isEmpty
                      ? Icon(
                          Icons.flag_circle,
                          size: 30,
                          color: Colors.white,
                        )
                      : null,
                  backgroundImage: homeController
                          .vpnInfo.value.contryLongName.isEmpty
                      ? null
                      : AssetImage(
                          "countryFlags/${homeController.vpnInfo.value.countryShortName.toLowerCase()}"),
                ),
              ),
              CustomWidget(
                titleText: homeController.vpnInfo.value.contryLongName.isEmpty
                    ? "60ms"
                    : "${homeController.vpnInfo.value.ping} ms",
                subTitleText: "Ping",
                roundWidgetWithIcon: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.black54,
                  child: Icon(
                    Icons.flag_circle,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          //button for vpn
          vpnRoundButton(),

          //2 round widget
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidget(
                titleText: "0 kbps",
                subTitleText: "DOWNLOAD",
                roundWidgetWithIcon: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.greenAccent,
                  child: Icon(
                    Icons.arrow_circle_down,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              CustomWidget(
                titleText: "0 kbps",
                subTitleText: "UPLOAD",
                roundWidgetWithIcon: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.redAccent,
                  child: Icon(
                    Icons.arrow_circle_up_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: locationSelectionBottomNavigation(context),
    );
  }
}
