import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openvpn_test_app/allModels/ip_info.dart';
import 'package:openvpn_test_app/allModels/network_ip_info.dart';
import 'package:openvpn_test_app/allWidgets/ip_info_widget.dart';
import 'package:openvpn_test_app/apiVpnGate/api_vpn_gate.dart';

class ConnectedNetworkDetail extends StatelessWidget {
  ConnectedNetworkDetail({super.key});

  final Rx<IPInfo> ipInfo = IPInfo.fromJson({}).obs;
  Future<void> getDetailInfo() async {
    await ApiVpnGate.retrieveIPDetails(ipInformation: ipInfo);
  }

  @override
  Widget build(BuildContext context) {
    getDetailInfo();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          "Connected Network IP Information",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      body: Obx(
        () => ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(3),
          children: [
            //IP address
            NetworkIPInfoWidget(
              networkIpInfoModel: NetworkIpInfoModel(
                title: "IP Address",
                subTitle: ipInfo.value.query,
                iconData: const Icon(
                  Icons.my_location_outlined,
                  color: Colors.redAccent,
                ),
              ),
            ),

            //isp
            NetworkIPInfoWidget(
              networkIpInfoModel: NetworkIpInfoModel(
                title: "Internet Service Provider",
                subTitle: ipInfo.value.internetServiceProvider,
                iconData: const Icon(
                  Icons.account_tree,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),

            //Location
            NetworkIPInfoWidget(
              networkIpInfoModel: NetworkIpInfoModel(
                title: "Location",
                subTitle: ipInfo.value.countryName.isEmpty
                    ? "Retrieving..."
                    : "${ipInfo.value.cityName}, ${ipInfo.value.regionName}",
                iconData: const Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.green,
                ),
              ),
            ),

            //Zip code
            NetworkIPInfoWidget(
              networkIpInfoModel: NetworkIpInfoModel(
                title: "Zip Code",
                subTitle: ipInfo.value.zipCode,
                iconData: const Icon(
                  CupertinoIcons.map_pin_ellipse,
                  color: Colors.purpleAccent,
                ),
              ),
            ),

            //time zone
            NetworkIPInfoWidget(
              networkIpInfoModel: NetworkIpInfoModel(
                title: "Time Zone",
                subTitle: ipInfo.value.timeZone,
                iconData: const Icon(
                  Icons.share_arrival_time_outlined,
                  color: Colors.cyan,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            ipInfo.value = IPInfo.fromJson({});
            ApiVpnGate.retrieveIPDetails(ipInformation: ipInfo);
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(CupertinoIcons.refresh_circled),
        ),
      ),
    );
  }
}
