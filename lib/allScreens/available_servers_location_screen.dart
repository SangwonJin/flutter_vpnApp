import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openvpn_test_app/allControllers/vpn_location_controller.dart';

class AvailableVpnServerLocation extends StatelessWidget {
  AvailableVpnServerLocation({super.key});

  final VpnLocationController vpnLocationController = VpnLocationController();

  Widget loadingWidget() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.redAccent,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Gathering Free VPN Locations...",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget noVpnServerFoundUiWidget() {
    return Center(
      child: Text(
        "No VPNs Found. Try Again.",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget vpnAvailableServerWidget() {
    return ListView.builder(
        itemCount: vpnLocationController.freeAvailableVpnServersList.length,
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(3),
        itemBuilder: (context, index) {});
  }

  @override
  Widget build(BuildContext context) {
    if (vpnLocationController.freeAvailableVpnServersList.isEmpty) {
      vpnLocationController.retrieveVpnInfomation();
    }

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
              "VPN Location (${vpnLocationController.freeAvailableVpnServersList.length.toString()})"),
        ),
        body: vpnLocationController.isLoadingNewLocations.value
            ? loadingWidget()
            : vpnLocationController.freeAvailableVpnServersList.isEmpty
                ? noVpnServerFoundUiWidget()
                : vpnAvailableServerWidget(),
      ),
    );
  }
}
