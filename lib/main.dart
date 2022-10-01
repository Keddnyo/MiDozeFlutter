import 'dart:ui';
import 'package:flutter/material.dart';
import 'remote/requests.dart';

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

  Widget button(String label, Function() onPressed) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
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
        child: textField('appname', appName),
      ),
      SimpleDialogOption(
        child: textField('appVersion', appVersion),
      ),
      SimpleDialogOption(
        child: button(
          'OK',
          () {
            getFirmwareData(context, deviceSource.text, productionSource.text,
                appName.text, appVersion.text);
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
          },
        ),
      ),
    ];
  }

  SimpleDialog alert = SimpleDialog(
    title: const Text('Request'),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0))),
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
