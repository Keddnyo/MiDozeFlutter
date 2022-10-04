import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../data_models/remote/watchface.dart' as watchface_remote;
import 'package:http/http.dart' as http;

Widget watchfaceList() {
  return FutureBuilder(
    future: anything(),
    builder: ((context, snapshot) {
      if (snapshot.data == null) {
        return const Text('Error');
      } else {
        var response = snapshot.data.toString();
        var json = jsonDecode(response);
        var watchface =
            watchface_remote.Watchface.fromJson(json as Map<String, dynamic>);
        var title = watchface.title;
        var preview = watchface.preview;
        var url = watchface.url;
        var length = watchface.length;

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
          ),
          itemCount: length,
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
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(preview),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        title,
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
      }
      return const CircularProgressIndicator();
    }),
  );
}

Future<String> anything() async {
  return await http.read(
    Uri.https(
      'cors-anywhere.herokuapp.com',
      'https://watch-appstore.iot.mi.com/api/watchface/prize/tabs',
      {
        'model': 'hmpace.watch.v7',
      },
    ),
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
      'Accept': '*/*'
    },
  );
}
