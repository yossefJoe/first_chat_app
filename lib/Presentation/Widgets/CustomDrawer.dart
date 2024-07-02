import 'package:chatapp/Presentation/Pages/ContactsPage.dart';
import 'package:chatapp/Presentation/Pages/FirendRequests.dart';
import 'package:chatapp/Presentation/Pages/SearchPeople.dart';
import 'package:chatapp/Presentation/Pages/gotopage.dart';
import 'package:chatapp/Presentation/Widgets/CustomListTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  User? auth = FirebaseAuth.instance.currentUser;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              currentAccountPicture: Container(
                child: Icon(
                  Icons.person_2,
                  size: 70,
                  color: Colors.white,
                ),
                height: 70,
                width: 70,
                decoration:
                    BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
              ),
              accountName: FutureBuilder(
                future:
                    usersCollection.where('uid', isEqualTo: auth!.uid).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                        snapshot.data!.docs[0]['displayName'].toString());
                  }
                  return Text(auth!.displayName.toString());
                },
              ),
              accountEmail: Text(auth!.email.toString())),
          Column(
            children: [
              CustomListTile(
                isfreinds: false,
                icon: Icons.messenger,
                istop: true,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => gotopage()),
                    (Route<dynamic> route) => false,
                  );
                },
                title: 'Home',
              ),
              CustomListTile(
                isfreinds: false,
                icon: Icons.group,
                istop: false,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ContactsPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                title: 'Contacts',
              ),
              CustomListTile(
                isfreinds: false,
                icon: Icons.search,
                istop: false,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SearchPeaople()),
                    (Route<dynamic> route) => false,
                  );
                },
                title: 'Search',
              ),
              CustomListTile(
                isfreinds: true,
                icon: Icons.list,
                istop: false,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => FriendRequests()),
                    (Route<dynamic> route) => false,
                  );
                },
                title: 'Friend Requests',
              ),
              CustomListTile(
                isfreinds: false,
                icon: Icons.person,
                istop: false,
                onTap: () {},
                title: 'Profile',
              ),
            ],
          )
        ],
      ),
    );
  }
}
