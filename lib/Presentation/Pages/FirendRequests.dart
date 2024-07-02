import 'package:chatapp/Presentation/Pages/ContactsPage.dart';
import 'package:chatapp/Presentation/Pages/SearchPeople.dart';
import 'package:chatapp/Presentation/Pages/gotopage.dart';
import 'package:chatapp/Presentation/Widgets/CustomDrawer.dart';
import 'package:chatapp/Presentation/Widgets/CustomMaterialButton.dart';
import 'package:chatapp/Presentation/Widgets/Customappbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FriendRequests extends StatelessWidget {
  FriendRequests({super.key});
  final users = FirebaseFirestore.instance.collection('users');
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Future<void> removerequest(
      String requester, String image, String time, String username) async {
    final querySnapshot =
        await users.where('displayName', isEqualTo: username).get();
    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      await doc.reference.update({
        'requests': FieldValue.arrayRemove([
          {
            'from_name': requester,
            'from_image_url': image,
            'reques_time': time,
          }
        ])
      });
      print('Request Removed');
    } else {
      print('Removed already');
    }
  }

  Future<void> accept(
      String contact_name, String contact_image, String currentuser) async {
    final querySnapshot =
        await users.where('displayName', isEqualTo: currentuser).get();
    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      await doc.reference.update({
        'contacts': FieldValue.arrayUnion([
          {
            'Contact_name': contact_name,
            'Contact_image_url': contact_image,
          }
        ])
      });
      print('Request Removed');
    } else {
      print('Removed already');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Scaffold(
        drawer: CustomDrawer(),
        appBar: CustomAppBar2(context, false, 'Friend Requests'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                StreamBuilder(
                  stream: users.where('uid', isEqualTo: uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                color: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.white,
                                            child: Center(
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(snapshot.data!.docs[0]
                                              ['requests'][index]['from_name']),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CustomMaterialButton(
                                            text: 'Accept',
                                            onPressed: () {
                                              accept(
                                                  snapshot.data!.docs[0]
                                                          ['requests'][index]
                                                      ['from_name'],
                                                  snapshot.data!.docs[0]
                                                          ['requests'][index]
                                                      ['from_image_url'],
                                                  snapshot.data!.docs[0]
                                                      ['displayName']);
                                              removerequest(
                                                  snapshot.data!.docs[0]
                                                          ['requests'][index]
                                                      ['from_name'],
                                                  snapshot.data!.docs[0]
                                                          ['requests'][index]
                                                      ['from_image_url'],
                                                  snapshot.data!.docs[0]
                                                          ['requests'][index]
                                                      ['reques_time'],
                                                  snapshot.data!.docs[0]
                                                      ['displayName']);
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CustomMaterialButton(
                                            text: 'Remove',
                                            onPressed: () {
                                              removerequest(
                                                  snapshot.data!.docs[0]
                                                          ['requests'][index]
                                                      ['from_name'],
                                                  snapshot.data!.docs[0]
                                                          ['requests'][index]
                                                      ['from_image_url'],
                                                  snapshot.data!.docs[0]
                                                          ['requests'][index]
                                                      ['reques_time'],
                                                  snapshot.data!.docs[0]
                                                      ['displayName']);
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs[0]['requests'].length,
                        ),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No friend requests.'));
                    } else {
                      return CircularProgressIndicator(
                        color: Colors.indigo,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
