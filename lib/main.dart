import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firmware.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiDoze',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const MyHomePage(title: 'MiDoze'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: request());
  }

  Widget list() {
    return Center(
      child: ListView.builder(
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Column(
                    children: [
                      Image.network(
                          'https://raw.githubusercontent.com/Keddnyo/MiDoze/master/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png'),
                      Text(
                        '${index + 1}. Amazfit Bip',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(), labelText: label),
      ),
    );
  }

  var deviceSource = TextEditingController();
  var productionSource = TextEditingController();
  var appName = TextEditingController();
  var appVersion = TextEditingController();
  var response = TextEditingController();

  Widget submitButton(String label) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: () {
          _loadFirmwareData();
        },
        child: Text(label),
      ),
    );
  }

  Widget importButton(String label) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: () {
          deviceSource.text = '24';
          productionSource.text = '256';
          appName.text = 'com.xiaomi.hm.health';
          appVersion.text = '6.3.3_50627';
        },
        child: Text(label),
      ),
    );
  }

  Widget clearButton(String label) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: () {
          deviceSource.text = '';
          productionSource.text = '';
          appName.text = '';
          appVersion.text = '';
        },
        child: Text(label),
      ),
    );
  }

  Widget request() {
    return Center(
      child: ListView(
        children: [
          textField('deviceSource', deviceSource),
          textField('productionSource', productionSource),
          textField('appname', appName),
          textField('appVersion', appVersion),
          importButton('Import'),
          submitButton('Submit'),
          clearButton('Clear')
        ],
      ),
    );
  }

  void _loadFirmwareData() async {
    await http.get(
      Uri(
        scheme: 'https',
        host: 'cors-anywhere.herokuapp.com',
        path: 'https://api.amazfit.com/devices/ALL/hasNewVersion',
        queryParameters: {
          'productId': '0',
          'vendorSource': '0',
          'resourceVersion': '0',
          'firmwareFlag': '0',
          'vendorId': '0',
          'resourceFlag': '0',
          'productionSource': productionSource.text,
          'userid': '0',
          'userId': '0',
          'deviceSource': deviceSource.text,
          'fontVersion': '0',
          'fontFlag': '0',
          'appVersion': appVersion.text,
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
        'appname': appName.text,
        'v': '0',
        'apptoken': '0',
        'lang': 'en_US',
        'Host': 'api.amazfit.com',
        'Connection': 'Keep-Alive',
        'accept-encoding': 'gzip',
        'accept': '*/*',
        'Access-Control-Allow-Origin': '*',
      },
    ).then(
      (firmware) {
        if (firmware.statusCode == 200) {
          var decodedResponse = jsonDecode(firmware.body);
          if (decodedResponse['firmwareUrl'] != null) {
            var _firmwareUrl = Firmware.fromJson(decodedResponse).firmwareUrl;
            _launchUrl(_firmwareUrl);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Download failed.'),
            ),
          );
        }
      },
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
