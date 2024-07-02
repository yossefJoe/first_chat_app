import 'package:chatapp/Auth/Signin.dart';
import 'package:chatapp/Auth/Signup.dart';
import 'package:chatapp/Constants/Constants.dart';
import 'package:chatapp/Presentation/Widgets/CustomButton.dart';
import 'package:chatapp/Presentation/Widgets/Customappbar.dart';
import 'package:flutter/material.dart';

class ChooseSigning extends StatelessWidget {
  const ChooseSigning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 20),
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.indigo, width: 2),
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                            image: AssetImage(
                              imagepath + 'choose.png',
                            )),
                        shape: BoxShape.circle)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                child: Text(
                  'Welcome to Instachatty',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  'Stay in Touch With your Best Freinds.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: CustomButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Signin(),
                      ));
                    },
                    text: 'Log In',
                    color: Colors.indigo,
                    textColor: Colors.white,
                    bordercolor: Colors.transparent),
              ),
              CustomButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ));
                  },
                  text: 'Sign Up',
                  color: Colors.white,
                  textColor: Colors.indigo,
                  bordercolor: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
