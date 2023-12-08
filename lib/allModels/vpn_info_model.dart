class VpnInfoModel {
  late final String hostName;
  late final String ip;
  late final String ping;
  late final int speed;
  late final String contryLongName;
  late final String countryShortName;
  late final int vpnSessionsNum;
  late final String base64OpenVPNConfigurationsData;

  VpnInfoModel({
    required this.hostName,
    required this.ip,
    required this.ping,
    required this.speed,
    required this.contryLongName,
    required this.countryShortName,
    required this.vpnSessionsNum,
    required this.base64OpenVPNConfigurationsData,
  });

  VpnInfoModel.fromJson(Map<String, dynamic> jsonData) {
    hostName = jsonData["HostName"] ?? "";
    ip = jsonData["Ip"] ?? "";
    ping = jsonData["Ping"] ?? "";
    speed = jsonData["Speed"] ?? 0;
    contryLongName = jsonData["ContryLong"] ?? "";
    countryShortName = jsonData["CountryShort"] ?? "";
    vpnSessionsNum = jsonData["NumVpnSessions"] ?? 0;
    base64OpenVPNConfigurationsData =
        jsonData["OpenVPN_ConfigData_Base64"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{
      "HostName": hostName,
      "Ip": ip,
      "Ping": ping,
      "Speed": speed,
      "ContryLong": contryLongName,
      "CountryShort": countryShortName,
      "NumVpnSessions": vpnSessionsNum,
      "OpenVPN_ConfigData_Base64": base64OpenVPNConfigurationsData,
    };

    return jsonData;
  }
}
