class Firmware {
  final String firmwareVersion,
      firmwareUrl,
      resourceVersion,
      resourceUrl,
      baseResourceVersion,
      baseResourceUrl,
      fontVersion,
      fontUrl,
      gpsVersion,
      gpsUrl;

  Firmware({
    required this.firmwareVersion,
    required this.firmwareUrl,
    required this.resourceVersion,
    required this.resourceUrl,
    required this.baseResourceVersion,
    required this.baseResourceUrl,
    required this.fontVersion,
    required this.fontUrl,
    required this.gpsVersion,
    required this.gpsUrl,
  });

  factory Firmware.fromJson(Map<String, dynamic> json) {
    return Firmware(
      firmwareVersion: json['firmwareVersion'],
      firmwareUrl: json['firmwareUrl'],
      resourceVersion: json['resourceVersion'],
      resourceUrl: json['resourceUrl'],
      baseResourceVersion: json['baseResourceVersion'],
      baseResourceUrl: json['baseResourceUrl'],
      fontVersion: json['fontVersion'],
      fontUrl: json['fontUrl'],
      gpsVersion: json['gpsVersion'],
      gpsUrl: json['gpsUrl'],
    );
  }
}
