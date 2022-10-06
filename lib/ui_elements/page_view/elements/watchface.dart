import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../data_models/remote/watchface.dart' as watchface_remote;
import 'package:http/http.dart' as http;

Widget watchfaceList() {
  return FutureBuilder<List<watchface_remote.Watchface>>(
    future: anything(),
    builder: ((context, snapshot) {
      if (snapshot.data != null) {
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
          ),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
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
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(snapshot.data![index].preview),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        snapshot.data![index].title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      return const CircularProgressIndicator();
    }),
  );
}

Future<List<watchface_remote.Watchface>> anything() async {
  var response = await http.read(
    Uri.https(
      'api.allorigins.win',
      'raw',
      {
        'url': Uri.http(
          'watch-appstore.iot.mi.com',
          'api/watchface/prize/tabs',
          {
            'model': 'hmpace.watch.v7',
          },
        ).toString(),
      },
    ),
    headers: {
      'Watch-Appstore-Common': '_locale=us&_language=en',
      // 'Access-Control-Allow-Origin': '*',
      // 'Content-Type': 'application/json',
      // 'Accept': '*/*'
    },
  );

  var json = jsonDecode(response) as Map<String, dynamic>;

  List<watchface_remote.Watchface> watchfaceArray = [];

  for (var d = 0; d < json.length; d++) {
    var watchfaceList = json['data'][d]['list'] as List<dynamic>;

    for (var w = 0; w < watchfaceList.length; w++) {
      var watchface = watchfaceList[w] as Map<String, dynamic>;

      watchfaceArray.add(watchface_remote.Watchface(
          title: watchface['display_name'],
          preview: watchface['icon'],
          url: watchface['config_file']));
    }
  }

  return watchfaceArray;
}
