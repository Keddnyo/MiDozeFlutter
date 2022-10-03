import 'package:flutter/material.dart';
import 'ui_elements/dialog.dart';
import 'remote/requests.dart';
import '../repositories/application.dart' as app_repo;

void main() {
  runApp(const MyApp());
}

MaterialColor accentColor = Colors.green;

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
  String appBarTitle = 'Apps';

  void changeTitle(String title) {
    setState(() {
      appBarTitle = title;
    });
  }

  int index = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple,
              accentColor,
            ],
          ),
        ),
        child: deviceList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(Icons.access_time_outlined),
              label: "Dials",
              backgroundColor: accentColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.memory_outlined),
              label: "ROMs",
              backgroundColor: accentColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.widgets_outlined),
              label: "Apps",
              backgroundColor: accentColor)
        ],
        currentIndex: index,
        onTap: (int i) {
          setState(
            () {
              index = i;

              switch (i) {
                case 0:
                  changeTitle('Dials');
                  accentColor = Colors.deepOrange;
                  break;
                case 2:
                  changeTitle('Apps');
                  accentColor = Colors.green;
                  break;
                default:
                  changeTitle('ROMs');
                  accentColor = Colors.blue;
              }
            },
          );
        },
        showUnselectedLabels: false,
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
        app_repo.Application.appList.length,
        (index) => InkWell(
          onTap: () => {openUrl(app_repo.Application.appList[index].url)},
          child: Card(
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
                    child:
                        Image.asset(app_repo.Application.appList[index].icon),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text(
                      app_repo.Application.appList[index].title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
