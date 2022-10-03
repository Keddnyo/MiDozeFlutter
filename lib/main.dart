import 'dart:ui';

import 'package:flutter/material.dart';
import 'ui_elements/dialog.dart';
import 'remote/requests.dart';
import 'ui_elements/page_view/elements/application.dart';

void main() {
  runApp(const MyApp());
}

MaterialColor accentColor = Colors.deepPurple;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiDoze',
      theme: ThemeData(primarySwatch: accentColor),
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

  int pageIndex = 2;

  void pageChanged(int index) {
    setState(
      () {
        pageIndex = index;
      },
    );
  }

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
              accentColor,
              Colors.red,
            ],
          ),
        ),
        child: PageView(
          controller: pageController,
          scrollBehavior: AppScrollBehavior(),
          scrollDirection: Axis.horizontal,
          onPageChanged: (currentPage) {
            pageChanged(currentPage);
          },
          children: [
            const Text('Page 1'),
            const Text('Page 2'),
            deviceList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined),
            label: "Dials",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.memory_outlined),
            label: "ROMs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets_outlined),
            label: "Apps",
          )
        ],
        currentIndex: pageIndex,
        onTap: (int i) {
          setState(
            () {
              pageIndex = i;
              pageController.animateToPage(pageIndex,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);

              switch (i) {
                case 0:
                  changeTitle('Dials');
                  break;
                case 2:
                  changeTitle('Apps');
                  break;
                default:
                  changeTitle('ROMs');
              }
            },
          );
        },
        showUnselectedLabels: false,
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

PageController pageController = PageController(
  initialPage: 2,
  keepPage: true,
);
