import 'package:flutter/material.dart';
import '../../../data_models/remote/watchface.dart' as watchface_remote;
import '../../../remote/requests.dart';

var request = getWatchfaceData('hmpace.watch.v7');

@override
initState() {
  request;
}

Widget watchfaceList() {
  return FutureBuilder<watchface_remote.Watchface>(
    future: request,
    builder: ((context, snapshot) {
      if (snapshot.hasData) {
        final count = snapshot.data!.length;

        GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
          ),
          itemCount: count,
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
                      child: Image.network(snapshot.data!.preview),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        snapshot.data!.title,
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
