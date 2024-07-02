import 'package:chatapp/Auth/choosesign.dart';
import 'package:chatapp/Constants/Constants.dart';
import 'package:chatapp/Presentation/Widgets/CustomPageviewItem.dart';
import 'package:chatapp/Presentation/Widgets/Customappbar.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/widgets.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController pageController = PageController(
    initialPage: 0,
  );
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(context),
        backgroundColor: Colors.blue,
        body: Stack(
          children: [
            PageView(
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              controller: pageController,
              children: [
                PageViewItem(
                  label: 'PRIVATE MESSAGES',
                  image: 'private.png',
                  text: 'Coomunicate with your friends via private messages.',
                ),
                PageViewItem(
                  label: 'GROUP CHATS',
                  image: 'gchat.png',
                  text: 'Create group chats and stay in touch with your gang.',
                ),
                PageViewItem(
                  label: 'SEND PHOTOS',
                  image: 'insta.png',
                  text:
                      'Have Fun with your friends by sending photos\n and videos to each other.',
                ),
                PageViewItem(
                  label: 'GET NOTIFIED',
                  image: 'bell.png',
                  text:
                      'Receive notifications when friends are looking for you.',
                ),
              ],
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.7,
                left: 0,
                right: 0,
                bottom: 0,
                child: DotsIndicator(
                  position: currentPage,
                  dotsCount: 4,
                  decorator: DotsDecorator(activeColor: Colors.white),
                )),
            Visibility(
              visible: currentPage == 3,
              child: Positioned(
                top: MediaQuery.of(context).size.height * 0.9,
                left: MediaQuery.of(context).size.width * 0.7,
                right: 0,
                bottom: 0,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => ChooseSigning()),
                        (route) => false);
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
