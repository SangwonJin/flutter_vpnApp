import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openvpn_test_app/allModels/vpn_configuration.dart';
import 'package:openvpn_test_app/appPreferences/appPreferences.dart';
import 'package:openvpn_test_app/vpnEngine/vpn_engine.dart';

import '../allModels/vpn_info_model.dart';

class HomeController extends GetxController {
  final Rx<VpnInfoModel> vpnInfo = AppPreferences.vpnInfoObj.obs;
  final Rx<String> vpnConnectionState = VpnEngine.vpnDisConnectedNow.obs;

  void connectToVpnNow() async {
    if (vpnInfo.value.base64OpenVPNConfigurationsData.isEmpty) {
      Get.snackbar(
          "County / Location", "Please select a country or location first");
      return;
    }

    if (vpnConnectionState.value == VpnEngine.vpnDisConnectedNow) {
      // vpnConnectionState.value = VpnEngine.vpnConnectingNow;
      final Uint8List vpnConfigData = Base64Decoder()
          .convert(vpnInfo.value.base64OpenVPNConfigurationsData);
      final String configuration = Utf8Decoder().convert(vpnConfigData);

      final VpnConfiguration vpnConfiguration = VpnConfiguration(
          userName: "vpn",
          password: "vpn",
          countryName: vpnInfo.value.contryLongName,
          config: configuration);
      await VpnEngine.startVpnNow(vpnConfiguration);
      vpnConnectionState.value = VpnEngine.vpnConnectedNow;
    } else {
      await VpnEngine.stopVpnNow();
      vpnConnectionState.value = VpnEngine.vpnDisConnectedNow;
    }
  }

  Color get getRoundVpnButtonColor {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisConnectedNow:
        return Colors.redAccent;

      case VpnEngine.vpnConnectedNow:
        return Colors.green;

      default:
        return Colors.orangeAccent;
    }
  }

  String get getRoundVpnButtonText {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisConnectedNow:
        return "Tap to Connect";

      case VpnEngine.vpnConnectedNow:
        return "Disconnect";

      default:
        return "Connecting...";
    }
  }
}
