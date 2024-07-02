import 'package:chatapp/Presentation/Widgets/CustomButton.dart';
import 'package:chatapp/Presentation/Widgets/CustomTextField.dart';
import 'package:chatapp/Loading.dart';
import 'package:chatapp/Presentation/Pages/gotopage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  var username, password, email, phoneNumber;
  GlobalKey<FormState> formState = new GlobalKey<FormState>();

  Future<void> saveUserInfo(User? user) async {
    if (user == null) return;
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final docSnapshot = await usersCollection.doc(user.uid).get();

    if (!docSnapshot.exists) {
      await usersCollection.doc(user.uid).set({
        'uid': user.uid,
        'displayName': username,
        'email': email,
        'photoURL': 'null',
        'phonenumber': phoneNumber,
        'createdAt': FieldValue.serverTimestamp(),
        'requests': [],
        'contacts': []
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Future<UserCredential?> signUp() async {
      var formdata = formState.currentState;

      if (formdata!.validate()) {
        formdata.save();
        try {
          showloading(context);
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          await saveUserInfo(credential.user);
          return credential;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      } else {
        print("Not valid");
      }
      return null;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Create new account",
                    style: TextStyle(fontSize: 30, color: Colors.indigo),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          child: Icon(
                            Icons.person_2,
                            size: 70,
                            color: Colors.white,
                          ),
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                        ),
                        Positioned(
                            child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      shape: BoxShape.circle),
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                            top: 35,
                            left: 35),
                      ],
                    ),
                  ),
                ),
                Form(
                    key: formState,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomTextField(
                          maxLength: 20,
                          hinttext: 'Full Name',
                          type: TextInputType.name,
                          obscureText: false,
                          validator: (value) {
                            if (value!.length < 5) {
                              return "UserName shouldn't be less than 5 characters";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (newvalue) {
                            username = newvalue;
                          },
                        ),
                        CustomTextField(
                          maxLength: 11,
                          hinttext: 'Phone Number',
                          type: TextInputType.phone,
                          obscureText: false,
                          validator: (value) {
                            if (value!.length < 11) {
                              return "Phone Number shouldn't be less than 11 Numbers";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (newvalue) {
                            phoneNumber = newvalue;
                          },
                        ),
                        CustomTextField(
                          maxLength: 30,
                          hinttext: 'Email Address',
                          type: TextInputType.emailAddress,
                          obscureText: false,
                          validator: (value) {
                            if (!value!.contains("@")) {
                              return "E-mail must contain @";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (newvalue) {
                            email = newvalue;
                          },
                        ),
                        CustomTextField(
                          maxLength: 30,
                          hinttext: 'Password',
                          type: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) {
                            if (value!.length < 7) {
                              return "Password shouldn't be less than 7 characters";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (newvalue) {
                            password = newvalue;
                          },
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 10, right: 50, left: 50),
                  child: CustomButton(
                    bordercolor: Colors.transparent,
                    textColor: Colors.white,
                    text: 'Sign Up',
                    color: Colors.indigo,
                    onPressed: () async {
                      UserCredential? response = await signUp();
                      if (response != null) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => gotopage()),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        print("Sign up failed");
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
