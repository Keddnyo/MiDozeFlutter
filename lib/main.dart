import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.deepPurple,
          systemNavigationBarColor: Colors.red,
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple,
              Colors.red,
            ],
          ),
        ),
        child: deviceList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time_outlined), label: "Dials"),
          BottomNavigationBarItem(
              icon: Icon(Icons.memory_outlined), label: "ROMs"),
          BottomNavigationBarItem(
              icon: Icon(Icons.widgets_outlined), label: "Apps")
        ],
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
        showUnselectedLabels: false,
        backgroundColor: Colors.red,
        selectedItemColor: Colors.white,
      ),
    );
  }

  Widget deviceList() {
    return GridView.extent(
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      padding: const EdgeInsets.all(15),
      maxCrossAxisExtent: 200,
      children: List.generate(
        50,
        (index) => Card(
          elevation: 10.0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset('assets/images/amazfit_bip.png'),
                ),
                const Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(
                    'Amazfit Bip',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
