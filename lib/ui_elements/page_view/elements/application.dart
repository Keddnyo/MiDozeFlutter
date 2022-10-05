import 'package:flutter/material.dart';
import '../../../remote/requests.dart';
import '../../../repositories/application.dart' as app_repo;

Widget appList() {
  return GridView.extent(
    crossAxisSpacing: 5,
    mainAxisSpacing: 5,
    padding: const EdgeInsets.all(10),
    maxCrossAxisExtent: 200,
    children: List.generate(
      app_repo.Application.appList.length,
      (index) => InkWell(
        onTap: () => {openUrl(app_repo.Application.appList[index].url)},
        child: Card(
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
                  child: Image.asset(app_repo.Application.appList[index].icon),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    app_repo.Application.appList[index].title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
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
