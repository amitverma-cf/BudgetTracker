import 'package:flutter/material.dart';

Future<dynamic> result(Future<dynamic> upload, BuildContext context,
    String success, String failed) {
  return upload
      .whenComplete(
    () => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        showCloseIcon: true,
        content: Text(success),
      ),
    ),
  )
      .catchError((err) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        showCloseIcon: true,
        content: Text(failed),
      ),
    );
    debugPrint(err);
    return Future.value(0);
  });
}
