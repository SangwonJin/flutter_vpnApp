import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openvpn_test_app/allControllers/home_controller.dart';
import 'package:openvpn_test_app/allModels/vpn_status.dart';
import 'package:openvpn_test_app/allScreens/available_servers_location_screen.dart';
import 'package:openvpn_test_app/allScreens/connected_network_ip_info_screen.dart';
import 'package:openvpn_test_app/allWidgets/custom_widget.dart';
import 'package:openvpn_test_app/allWidgets/timer_widget.dart';
import 'package:openvpn_test_app/appPreferences/appPreferences.dart';
import 'package:openvpn_test_app/vpnEngine/vpn_engine.dart';

import '../main.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});
  // final HomeController homeController = Get.put(HomeController());
  locationSelectionBottomNavigation(BuildContext context) {
    return SafeArea(
        child: Semantics(
      button: true,
      child: InkWell(
        onTap: () {
          Get.to(() => AvailableVpnServerLocation());
        },
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
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget vpnRoundButton() {
    return Column(
      children: [
        //Vpn button
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {
              controller.connectToVpnNow();
            },
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.getRoundVpnButtonColor.withOpacity(0.1),
              ),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.getRoundVpnButtonColor.withOpacity(0.3),
                ),
                child: Container(
                  width: sizeScreen.height * 0.14,
                  height: sizeScreen.height * 0.14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.getRoundVpnButtonColor.withOpacity(0.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        controller.getRoundVpnButtonText,
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
          ),
        ),

        const SizedBox(
          height: 20,
        ),
        //status of connection
        Container(
          margin: EdgeInsets.only(
              top: Get.height * 0.01, bottom: Get.height * 0.02),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.redAccent, borderRadius: BorderRadius.circular(16)),
          child: Text(
            controller.vpnConnectionState.value == VpnEngine.vpnDisConnectedNow
                ? "Not Connected"
                : controller.vpnConnectionState
                    .replaceAll("-", " ")
                    .toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),

        //timer
        Obx(
          () => TimerWidget(
              initTimerNow: controller.vpnConnectionState.value ==
                  VpnEngine.vpnConnectedNow),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    VpnEngine.snapshotVpnStage().listen((status) {
      controller.vpnConnectionState.value = status;
    });
    sizeScreen = Get.size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Free VPN'),
        leading: IconButton(
          icon: Icon(Icons.perm_device_info),
          onPressed: () {
            Get.to(() => ConnectedNetworkDetail());
          },
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
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomWidget(
                  titleText: controller.vpnInfo.value.contryLongName.isEmpty
                      ? "Location"
                      : controller.vpnInfo.value.contryLongName,
                  subTitleText: "FREE",
                  roundWidgetWithIcon: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.redAccent,
                    child: controller.vpnInfo.value.contryLongName.isEmpty
                        ? Icon(
                            Icons.flag_circle,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                    backgroundImage: controller
                            .vpnInfo.value.contryLongName.isEmpty
                        ? null
                        : AssetImage(
                            "countryFlags/${controller.vpnInfo.value.countryShortName.toLowerCase()}.png"),
                  ),
                ),
                CustomWidget(
                  titleText: controller.vpnInfo.value.contryLongName.isEmpty
                      ? "60ms"
                      : "${controller.vpnInfo.value.ping.toString()} ms",
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
          ),

          //button for vpn
          Obx(
            () => vpnRoundButton(),
          ),

          //2 round widget
          StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.snapshotVpnStatus(),
            builder: (context, dataSnapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWidget(
                    titleText: "${dataSnapshot.data?.byteIn ?? '0 kbps'}",
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
                    titleText: "${dataSnapshot.data?.byteOut ?? '0 kbps'}",
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
              );
            },
          )
        ],
      ),
      bottomNavigationBar: locationSelectionBottomNavigation(context),
    );
  }
}
