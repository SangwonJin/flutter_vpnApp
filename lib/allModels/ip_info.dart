class IPInfo {
  late final String countryName;
  late final String regionName;
  late final String cityName;
  late final String zipCode;
  late final String timeZone;
  late final String internetServiceProvider;
  late final String query;

  IPInfo({
    required this.countryName,
    required this.regionName,
    required this.cityName,
    required this.zipCode,
    required this.timeZone,
    required this.internetServiceProvider,
    required this.query,
  });

  // Factory constructor to create an instance of IPInfo from a JSON map
  factory IPInfo.fromJson(Map<String, dynamic> json) {
    return IPInfo(
      countryName: json['countryName'],
      regionName: json['regionName'] ?? '',
      cityName: json['cityName'] ?? '',
      zipCode: json['zip'] ?? '',
      timeZone: json['timezone'] ?? 'Unknown',
      internetServiceProvider: json['isp'] ?? 'Unknown',
      query: json['query'] ?? 'Not available',
    );
  }

  // Method to convert an instance of IPInfo to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'countryName': countryName,
      'regionName': regionName,
      'cityName': cityName,
      'zipCode': zipCode,
      'timeZone': timeZone,
      'internetServiceProvider': internetServiceProvider,
      'query': query,
    };
  }
}
