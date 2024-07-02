import 'package:chatapp/Auth/choosesign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(BuildContext context)
      : super(
          toolbarHeight: MediaQuery.of(context).size.height * 0.010,
          backgroundColor: Colors.indigo,
        );
}

class CustomAppBar2 extends AppBar {
  CustomAppBar2(BuildContext context, bool homepage, String text)
      : super(
          backgroundColor: Colors.indigoAccent,
          title: Text(text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          actions: homepage == true
              ? [
                  IconButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => ChooseSigning()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      icon: Icon(Icons.logout))
                ]
              : [],
        );
}
