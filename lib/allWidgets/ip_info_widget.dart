// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:openvpn_test_app/allModels/network_ip_info.dart';

class NetworkIPInfoWidget extends StatelessWidget {
  const NetworkIPInfoWidget({
    Key? key,
    required this.networkIpInfoModel,
  }) : super(key: key);

  final NetworkIpInfoModel networkIpInfoModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        leading: Icon(
          networkIpInfoModel.iconData.icon,
          size: networkIpInfoModel.iconData.size ?? 28,
        ),
        title: Text(networkIpInfoModel.title),
        subtitle: Text(networkIpInfoModel.subTitle),
      ),
    );
  }
}
