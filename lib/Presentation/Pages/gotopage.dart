import 'package:chatapp/Api/Emojies_Method.dart';
import 'package:chatapp/Auth/choosesign.dart';
import 'package:chatapp/Presentation/Widgets/CustomButton.dart';
import 'package:chatapp/Model/emojies.dart';
import 'package:chatapp/Auth/Signup.dart';
import 'package:chatapp/Presentation/Widgets/CustomDrawer.dart';
import 'package:chatapp/Presentation/Widgets/Customappbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class gotopage extends StatelessWidget {
  gotopage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Scaffold(
        drawer: CustomDrawer(),
        appBar: CustomAppBar2(context, true, 'Conversations'),
      ),
    );
  }
}
