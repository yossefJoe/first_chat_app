import 'package:flutter/material.dart';

showloading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("PLease Wait"),
          content: Container(
              height: 50,
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              ))),
        );
      });
}
