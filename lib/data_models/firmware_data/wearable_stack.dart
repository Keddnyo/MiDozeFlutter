import 'package:flutter_project/data_models/firmware_data/wearable.dart';

class WearableStack {
  final String name;
  final List<Wearable> wearable;

  WearableStack({
    required this.name,
    required this.wearable,
  });
}
