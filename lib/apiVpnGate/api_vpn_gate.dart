import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:openvpn_test_app/allModels/vpn_info_model.dart';
import 'package:openvpn_test_app/appPreferences/appPreferences.dart';

import '../allModels/ip_info.dart';

class ApiVpnGate {
  static Future<List<VpnInfoModel>> retrieveAllAvailableVpnServers() async {
    final List<VpnInfoModel> vpnServersList = [];

    try {
      final responseFromApi =
          await http.get(Uri.parse("http://www.vpngate.net/api/iphone/"));
      final String commaSeperatedValuesString =
          responseFromApi.body.split("#")[1].replaceAll("*", "");

      List<List<dynamic>> listData =
          const CsvToListConverter().convert(commaSeperatedValuesString);

      final header = listData[0];

      for (int counter = 1; counter < listData.length - 1; counter++) {
        Map<String, dynamic> jsonData = {};

        for (int innerCounter = 1;
            innerCounter < header.length;
            innerCounter++) {
          jsonData.addAll(
            {
              header[innerCounter].toString(): listData[counter][innerCounter],
            },
          );
        }

        vpnServersList.add(VpnInfoModel.fromJson(jsonData));
      }
    } catch (e) {
      Get.snackbar(
        'Error Occurred',
        '${e.toString()}',
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
      );
    }

    if (vpnServersList.isNotEmpty) {
      AppPreferences.vpnList = vpnServersList;
    }

    return vpnServersList;
  }

  static Future<void> retrieveIPDetails(
      {required Rx<IPInfo> ipInformation}) async {
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json/'));
      final dataFromApi = jsonDecode(response.body);

      ipInformation.value = IPInfo.fromJson(dataFromApi);
    } catch (e) {
      Get.snackbar(
        'Error Occurred',
        '${e.toString()}',
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
      );
    }
  }
}
