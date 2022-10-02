import 'device.dart';
import 'wearable.dart';

class Firmware {
  final Device device;
  final Wearable wearable;
  final String firmwareData;

  Firmware({
    required this.device,
    required this.wearable,
    required this.firmwareData,
  });
}
