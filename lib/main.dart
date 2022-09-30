import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'firmware.dart';

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
  String titleBarTitle = 'MiDoze';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleBarTitle),
        actions: [
          IconButton(
            onPressed: () {
              alertDialog(context);
            },
            tooltip: 'Request',
            icon: const Icon(Icons.menu_open_outlined),
          ),
          IconButton(
            onPressed: () {
              openUrl('https://github.com/keddnyo/MiDoze');
            },
            tooltip: 'GitHub',
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: pager(),
    );
  }

  Widget pager() {
    return PageView(
      scrollBehavior: AppScrollBehavior(),
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Center(
          child: Image.asset('assets/images/amazfit_bip.png'),
        ),
        Center(
          child: Image.asset('assets/images/amazfit_bip.png'),
        ),
        Center(
          child: Image.asset('assets/images/amazfit_bip.png'),
        ),
      ],
    );
  }
}

Future<void> openUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(url),
    );
  }
}

alertDialog(BuildContext context) {
  Widget textField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration:
          InputDecoration(border: const OutlineInputBorder(), labelText: label),
    );
  }

  var deviceSource = TextEditingController();
  var productionSource = TextEditingController();
  var appName = TextEditingController();
  var appVersion = TextEditingController();
  var country = TextEditingController();
  var lang = TextEditingController();

  Widget button(String label, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }

  void loadFirmwareData() async {
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
        'X-Requested-With': 'XMLHttpRequest',
      },
    ).then(
      (firmware) {
        if (firmware.statusCode == 200) {
          var decodedResponse = jsonDecode(firmware.body);
          if (decodedResponse['firmwareUrl'] != null) {
            var firmwareUrl = Firmware.fromJson(decodedResponse).resourceUrl;
            // ignore: deprecated_member_use
            launch(firmwareUrl);
          }
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

  dialogContent() {
    return <Widget>[
      SimpleDialogOption(
        child: textField('deviceSource', deviceSource),
      ),
      SimpleDialogOption(
        child: textField('productionSource', productionSource),
      ),
      SimpleDialogOption(
        child: textField('appVersion', appVersion),
      ),
      SimpleDialogOption(
        child: textField('appName', appName),
      ),
      SimpleDialogOption(
        child: textField('country', country),
      ),
      SimpleDialogOption(
        child: textField('lang', lang),
      ),
      SimpleDialogOption(
        child: button(
          'OK',
          () {
            loadFirmwareData();
          },
        ),
      ),
      SimpleDialogOption(
        child: button(
          'Import data',
          () {
            deviceSource.text = '24';
            productionSource.text = '256';
            appName.text = 'com.xiaomi.hm.health';
            appVersion.text = '6.3.3_50627';
            country.text = 'US';
            lang.text = 'en_US';
          },
        ),
      ),
      SimpleDialogOption(
        child: button(
          'Clear',
          () {
            deviceSource.text = '';
            productionSource.text = '';
            appName.text = '';
            appVersion.text = '';
            country.text = '';
            lang.text = '';
          },
        ),
      ),
    ];
  }

  SimpleDialog alert = SimpleDialog(
    children: dialogContent(),
  );

  showDialog(context: context, builder: (context) => alert);
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
