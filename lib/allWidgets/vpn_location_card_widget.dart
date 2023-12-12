import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openvpn_test_app/allControllers/home_controller.dart';
import 'package:openvpn_test_app/allModels/vpn_info_model.dart';
import 'package:openvpn_test_app/appPreferences/appPreferences.dart';
import 'package:openvpn_test_app/main.dart';
import 'package:openvpn_test_app/vpnEngine/vpn_engine.dart';

class VpnLocationCardWidget extends StatelessWidget {
  VpnLocationCardWidget({super.key, required this.vpnInfoModel});

  final VpnInfoModel vpnInfoModel;
  final HomeController homeController = Get.put(HomeController());
  // final HomeController homeController = Get.find()<HomeController>();

  String formattedSpeedBytes(int speedBytes, int decimals) {
    if (speedBytes <= 0) {
      return "0 B";
    }
    const List sufFixesTitle = ["Bps", "Kbps", "Mbps", "Gbps", "Tbps"];
    int speed = (log(speedBytes) / log(1024)).floor();

    //return value would be 12.12 if decimals is 2
    return "${(speedBytes / pow(1024, speed)).toStringAsFixed(decimals)} ${sufFixesTitle[speed]}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          homeController.vpnInfo.value = vpnInfoModel;
          AppPreferences.vpnInfoObj = vpnInfoModel;

          if (homeController.vpnConnectionState.value ==
              VpnEngine.vpnConnectedNow) {
            VpnEngine.stopVpnNow();
            Future.delayed(
              Duration(seconds: 3),
              () => homeController.connectToVpnNow(),
            );
          } else {
            homeController.connectToVpnNow();
          }
          Get.back();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 30,
                  width: 40,
                  child: Image.asset(
                    "countryFlags/${vpnInfoModel.countryShortName.toLowerCase()}.png",
                    // height: 10,
                    // width: 10,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      vpnInfoModel.contryLongName,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.shutter_speed,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          formattedSpeedBytes(
                            vpnInfoModel.speed,
                            2,
                          ),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  vpnInfoModel.vpnSessionsNum.toString(),
                  style: TextStyle(
                    color: Theme.of(context).lightTextColor,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(
                  CupertinoIcons.person_2_alt,
                  color: Colors.redAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return Container(
      height: 50,
      width: 300,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            leading: Container(
              padding: const EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                "countryFlags/${vpnInfoModel.countryShortName.toLowerCase()}.png",
                height: 40,
                width: Get.width * 0.15,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(vpnInfoModel.contryLongName),

            //vpn speed
            subtitle: Row(
              children: [
                Icon(
                  Icons.shutter_speed,
                  color: Colors.redAccent,
                  size: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  formattedSpeedBytes(
                    vpnInfoModel.speed,
                    2,
                  ),
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),

            //the number of sessions
            trailing: Row(
              children: [
                Text(
                  vpnInfoModel.vpnSessionsNum.toString(),
                  style: TextStyle(
                    color: Theme.of(context).lightTextColor,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(
                  CupertinoIcons.person_2_alt,
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
