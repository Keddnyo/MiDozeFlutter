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
      firmwareVersion: json['firmwareVersion'].toString(),
      firmwareUrl: json['firmwareUrl'].toString(),
      resourceVersion: json['resourceVersion'].toString(),
      resourceUrl: json['resourceUrl'].toString(),
      baseResourceVersion: json['baseResourceVersion'].toString(),
      baseResourceUrl: json['baseResourceUrl'].toString(),
      fontVersion: json['fontVersion'].toString(),
      fontUrl: json['fontUrl'].toString(),
      gpsVersion: json['gpsVersion'].toString(),
      gpsUrl: json['gpsUrl'].toString(),
    );
  }
}
