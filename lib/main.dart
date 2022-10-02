import 'package:flutter/material.dart';
import 'ui_elements/dialog.dart';
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
      theme: ThemeData(primarySwatch: Colors.blue),
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        title: Text(widget.title),
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
      body: deviceList(),
    );
  }

  Widget deviceList() {
    return GridView.extent(
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      padding: const EdgeInsets.all(15),
      maxCrossAxisExtent: 300,
      children: List.generate(
        50,
        (index) => Card(
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset('assets/images/amazfit_bip.png'),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Amazfit Bip',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
