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
      theme: ThemeData(primarySwatch: accentColor, useMaterial3: true),
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
  static List<String> titleList = ['Dials', 'ROMs', 'Apps'];
  var currentPageIndex = 2;
  String appBarTitle = titleList[2];

  void pageChanged(int index) {
    setState(
      () {
        currentPageIndex = index;
        appBarTitle = titleList[index];

        pageController.animateToPage(currentPageIndex,
            duration: const Duration(milliseconds: 250), curve: Curves.ease);
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
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
              useIndicator: true,
              selectedIndex: currentPageIndex,
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (index) {
                setState(
                  () {
                    pageChanged(index);
                  },
                );
              },
              destinations: [
                NavigationRailDestination(
                    icon: const Icon(Icons.access_time_outlined),
                    selectedIcon: const Icon(Icons.access_time),
                    label: Text(titleList[0])),
                NavigationRailDestination(
                    icon: const Icon(Icons.memory_outlined),
                    selectedIcon: const Icon(Icons.memory),
                    label: Text(titleList[1])),
                NavigationRailDestination(
                    icon: const Icon(Icons.widgets_outlined),
                    selectedIcon: const Icon(Icons.widgets),
                    label: Text(titleList[2])),
              ],
            ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purpleAccent,
                    Colors.orangeAccent,
                  ],
                ),
              ),
              child: PageView(
                controller: pageController,
                scrollBehavior: AppScrollBehavior(),
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  pageChanged(index);
                },
                children: [
                  const Text('Page 1'),
                  const Text('Page 2'),
                  deviceList(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              useLegacyColorScheme: false,
              selectedItemColor: accentColor,
              unselectedItemColor: Colors.black,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(Icons.access_time_outlined),
                  activeIcon: const Icon(Icons.access_time),
                  label: titleList[0],
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.memory_outlined),
                  activeIcon: const Icon(Icons.memory),
                  label: titleList[1],
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.widgets_outlined),
                  activeIcon: const Icon(Icons.widgets),
                  label: titleList[2],
                )
              ],
              currentIndex: currentPageIndex,
              onTap: (int i) {
                setState(
                  () {
                    pageChanged(i);
                  },
                );
              },
              showUnselectedLabels: false,
            )
          : null,
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
