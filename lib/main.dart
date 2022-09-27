import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  Widget textField(String label) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: TextEditingController(),
        decoration: InputDecoration(
            border: const OutlineInputBorder(), labelText: label),
      ),
    );
  }

  Widget button(String label) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(label),
      ),
    );
  }

  Widget request() {
    return Center(
      child: ListView(
        children: [
          textField('deviceSource'),
          textField('productionSource'),
          textField('appname'),
          textField('appVersion'),
          button('Submit')
        ],
      ),
    );
  }
}
