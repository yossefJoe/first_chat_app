import 'package:chatapp/Constants/Constants.dart';
import 'package:chatapp/Loading.dart';
import 'package:chatapp/Presentation/Pages/gotopage.dart';
import 'package:chatapp/Presentation/Widgets/CustomButton.dart';
import 'package:chatapp/Presentation/Widgets/CustomTextField.dart';
import 'package:chatapp/Presentation/Widgets/Customappbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signin extends StatelessWidget {
  Signin({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String password, email;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    // Save user info to Firestore
    await saveUserInfo(userCredential.user);
    return userCredential;
  }

  Future<void> saveUserInfo(User? user) async {
    if (user != null) {
      final usersCollection = FirebaseFirestore.instance.collection('users');
      DocumentSnapshot doc = await usersCollection.doc(user.displayName).get();

      if (!doc.exists) {
        await usersCollection.doc(user.uid).set({
          'uid': user.uid,
          'displayName': user.displayName,
          'email': user.email,
          'photoURL': user.photoURL,
          'phonenumber': user.phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
          'requests': [],
          'contacts': []
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> signin() async {
      try {
        showloading(context);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => gotopage()),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Password or email is incorrect"),
                title: Text("Try Again"),
                actions: [CloseButton()],
              );
            });
      }
    }

    return Scaffold(
      appBar: CustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  "Sign In",
                  style: TextStyle(fontSize: 30, color: Colors.indigo),
                ),
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        maxLength: 30,
                        hinttext: "Email",
                        obscureText: false,
                        onChanged: (newvalue) {
                          email = newvalue;
                        },
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (!value!.contains("@")) {
                            return "E-mail must contain @";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        maxLength: 30,
                        hinttext: "Password",
                        obscureText: true,
                        onChanged: (newvalue) {
                          password = newvalue;
                        },
                        type: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.length < 7) {
                            return "Password shouldn't be less than 7 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40),
                    child: CustomButton(
                      bordercolor: Colors.transparent,
                      color: Colors.indigo,
                      onPressed: signin,
                      text: 'Log In',
                      textColor: Colors.grey,
                    ),
                  ),
                ),
              ),
              Center(child: Text('OR')),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 50, right: 50),
                  child: ElevatedButton(
                      onPressed: () async {
                        UserCredential userCredential =
                            await signInWithGoogle();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => gotopage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStatePropertyAll(
                              BeveledRectangleBorder())),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            imagepath + 'google.png',
                            height: 20,
                          ),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
