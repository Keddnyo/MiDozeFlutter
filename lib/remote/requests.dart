import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../data_models/remote/firmware.dart';
import '../../../data_models/remote/watchface.dart' as watchface_remote;

getFirmwareData(
  BuildContext context,
  String deviceSource,
  String productionSource,
  String appname,
  String appVersion,
) async {
  await http.get(
    Uri.https(
      'cors-anywhere.herokuapp.com',
      'https://api.amazfit.com/devices/ALL/hasNewVersion',
      {
        'productId': '0',
        'vendorSource': '0',
        'resourceVersion': '0',
        'firmwareFlag': '0',
        'vendorId': '0',
        'resourceFlag': '0',
        'productionSource': productionSource,
        'userid': '0',
        'userId': '0',
        'deviceSource': deviceSource,
        'fontVersion': '0',
        'fontFlag': '0',
        'appVersion': appVersion,
        'appid': '0',
        'callid': '0',
        'channel': '0',
        'country': '0',
        'cv': '0',
        'device': '0',
        'deviceType': 'ALL',
        'device_type': 'android_phone',
        'firmwareVersion': '0',
        'hardwareVersion': '0',
        'lang': '0',
        'support8Bytes': 'true',
        'timezone': '0',
        'v': '0',
        'gpsVersion': '0',
        'baseResourceVersion': '0',
      },
    ),
    headers: {
      'hm-privacy-diagnostics': 'false',
      'country': 'US',
      'appplatform': 'android_phone',
      'hm-privacy-ceip': '0',
      'x-request-id': '0',
      'timezone': '0',
      'channel': '0',
      'user-agent': '0',
      'cv': '0',
      'appname': appname,
      'v': '0',
      'apptoken': '0',
      'lang': 'en_US',
      'Host': 'api.amazfit.com',
      'Connection': 'Keep-Alive',
      'accept-encoding': 'gzip',
      'accept': '*/*',
      'Access-Control-Allow-Origin': '*',
      'X-Requested-With': 'XMLHttpRequest',
    },
  ).then(
    (firmware) {
      if (firmware.statusCode == 200) {
        var decodedResponse = jsonDecode(firmware.body);
        if (decodedResponse['firmwareUrl'] != null) {
          var firmwareUrl = Firmware.fromJson(decodedResponse).resourceUrl;
          // ignore: deprecated_member_use
          openUrl(firmwareUrl);
        }
      } else if (firmware.statusCode == 403) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enable CORS: ${firmware.statusCode}.'),
            action: SnackBarAction(
              label: 'Enable',
              onPressed: () {
                // ignore: deprecated_member_use
                openUrl('https://cors-anywhere.herokuapp.com/corsdemo');
              },
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download failed: ${firmware.statusCode}.'),
          ),
        );
      }
    },
  );
}

openUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(url),
    );
  }
}

Future<watchface_remote.Watchface> getWatchfaceData(
  String tag,
) async {
  return await http
      .read(
    Uri.https(
      'cors-anywhere.herokuapp.com',
      'https://watch-appstore.iot.mi.com/api/watchface/prize/tabs',
      {
        'model': tag,
      },
    ),
  )
      .then((response) {
    return watchface_remote.Watchface.fromJson(jsonDecode(response));
  });
}
