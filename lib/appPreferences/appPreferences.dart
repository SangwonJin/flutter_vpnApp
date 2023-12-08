import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../allModels/vpn_info_model.dart';

class AppPreferences {
  static late Box boxOfData;

  static Future<void> initHive() async {
    await Hive.initFlutter();

    boxOfData = await Hive.openBox("data");
  }

  //saving user's choice about theme selection
  static bool get isModeDark => boxOfData.get("isModeDark") ?? false;
  static set isModeDark(bool value) => boxOfData.put("isModeDark", value);

  //for saving single selected vpn details
  static VpnInfoModel get vpnInfoObj =>
      VpnInfoModel.fromJson(jsonDecode(boxOfData.get("vpn") ?? '{}'));
  static set vpnInfoObj(VpnInfoModel value) =>
      boxOfData.put("vpn", jsonEncode(value));

  //for saving all vpn servers details
  static List<VpnInfoModel> get vpnList {
    List<VpnInfoModel> tempVpnList = [];
    final dataVpn = jsonDecode(boxOfData.get("vpnList") ?? '[]');

    for (var data in dataVpn) {
      tempVpnList.add(VpnInfoModel.fromJson(data));
    }
    return tempVpnList;
  }

  static set vpnList(List<VpnInfoModel> valueList) =>
      boxOfData.put("vpnList", valueList);
}
