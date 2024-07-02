import 'package:chatapp/Presentation/Pages/ChatScreen.dart';
import 'package:chatapp/Presentation/Widgets/CustomDrawer.dart';
import 'package:chatapp/Presentation/Widgets/Customappbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  ContactsPage({super.key});
  var users = FirebaseFirestore.instance.collection('users');
  String userid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Scaffold(
        drawer: CustomDrawer(),
        appBar: CustomAppBar2(context, false, 'Contacts'),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                      suffixIcon:
                          IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      hintText: 'Search Contacts',
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo))),
                ),
                leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ),
            Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: users.where('uid', isEqualTo: userid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                        index: index,
                                        chat: snapshot,
                                      ),
                                    ));
                                  },
                                  title: Text(
                                    snapshot
                                        .data!
                                        .docs[0]['contacts'][index]
                                            ['Contact_name']
                                        .toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  trailing: MaterialButton(
                                    height: 30,
                                    onPressed: () {},
                                    child: Text(
                                      'Unfriend',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                    color: Colors.indigo,
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
                                  visible:
                                      index == snapshot.data!.docs.length - 1
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
                        itemCount: snapshot.data!.docs[0]['contacts'].length,
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('You Have No Contacts'));
                    } else {
                      return CircularProgressIndicator(color: Colors.indigo);
                    }
                  },
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
