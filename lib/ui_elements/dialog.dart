import 'package:flutter/material.dart';
import '../remote/requests.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return alertDialog(context);
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
    ];
  }

  SimpleDialog alert = SimpleDialog(
    title: Row(
      children: [
        const Text('Request'),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: 'Close',
          icon: const Icon(Icons.close),
        ),
      ],
    ),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0))),
    children: dialogContent(),
  );

  showDialog(
      context: context, barrierDismissible: false, builder: (context) => alert);
}
