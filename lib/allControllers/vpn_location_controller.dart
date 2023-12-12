import 'package:get/get.dart';
import 'package:openvpn_test_app/allModels/vpn_info_model.dart';
import 'package:openvpn_test_app/apiVpnGate/api_vpn_gate.dart';
import 'package:openvpn_test_app/appPreferences/appPreferences.dart';

class VpnLocationController extends GetxController {
  List<VpnInfoModel> freeAvailableVpnServersList = AppPreferences.vpnList;

  final RxBool isLoadingNewLocations = false.obs;

  Future<void> retrieveVpnInfomation() async {
    isLoadingNewLocations.value = true;
    freeAvailableVpnServersList.clear();

    freeAvailableVpnServersList =
        await ApiVpnGate.retrieveAllAvailableVpnServers();

    isLoadingNewLocations.value = false;
  }
}
