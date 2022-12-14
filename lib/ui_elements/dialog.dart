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
    title: const Text('Request'),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    children: dialogContent(),
  );

  showDialog(context: context, builder: (context) => alert);
}
