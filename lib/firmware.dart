class Firmware {
  final String firmwareVersion;
  final String firmwareUrl;

  Firmware({
    required this.firmwareVersion,
    required this.firmwareUrl,
  });

  factory Firmware.fromJson(Map<String, dynamic> json) {
    return Firmware(
      firmwareVersion: json['firmwareVersion'],
      firmwareUrl: json['firmwareUrl'],
    );
  }
}
