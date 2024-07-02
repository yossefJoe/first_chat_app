import 'package:chatapp/Presentation/Widgets/CustomDrawer.dart';
import 'package:chatapp/Presentation/Widgets/Customappbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPeaople extends StatefulWidget {
  SearchPeaople({super.key});

  @override
  State<SearchPeaople> createState() => _SearchPeaopleState();
}

class _SearchPeaopleState extends State<SearchPeaople> {
  var users = FirebaseFirestore.instance.collection('users');
  String userid = FirebaseAuth.instance.currentUser!.uid;
  DateTime now = DateTime.now();
  int selectedIndex = -1;
  Future<void> addfriend(String from_name, String to_name) async {
    final querySnapshot =
        await users.where('displayName', isEqualTo: to_name).get();
    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      await doc.reference.update({
        'requests': FieldValue.arrayUnion([
          {
            'from_name': from_name,
            'from_image_url': 'null',
            'reques_time': now.toString(),
          }
        ])
      });
      print('Request sent to ${to_name}');
    } else {
      print('Already Requested');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Scaffold(
        drawer: CustomDrawer(),
        appBar: CustomAppBar2(context, false, 'Search'),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.close)),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                        hintText: 'Search for People',
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo))),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: users.where('uid', isNotEqualTo: userid).get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5, top: 10, bottom: 10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        snapshot.data!.docs[index]
                                            ['displayName'],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      trailing: FutureBuilder(
                                        future: users
                                            .where('uid', isEqualTo: userid)
                                            .get(),
                                        builder: (context, user) {
                                          return MaterialButton(
                                            height: 30,
                                            onPressed: () {
                                              setState(() {
                                                selectedIndex = index;
                                              });
                                              addfriend(
                                                  user.data!.docs[0]
                                                      ['displayName'],
                                                  snapshot.data!.docs[index]
                                                      ['displayName']);
                                            },
                                            child: Text(
                                              selectedIndex == index
                                                  ? 'Cancel'
                                                  : 'Add Friend',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                            color: Colors.indigo,
                                          );
                                        },
                                      ),
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey,
                                        child: Center(
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: index ==
                                              snapshot.data!.docs.length - 1
                                          ? false
                                          : true,
                                      child: Divider(
                                        color: Colors.black,
                                        thickness: 1,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return CircularProgressIndicator(
                            color: Colors.indigo,
                          );
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
