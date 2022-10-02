import 'package:flutter_project/data_models/firmware_data/application.dart';
import 'package:flutter_project/data_models/firmware_data/region.dart';

class Wearable {
  final String deviceSource, productionSource;
  final Application application;
  final Region region;

  Wearable({
    required this.deviceSource,
    required this.productionSource,
    required this.application,
    required this.region,
  });
}
