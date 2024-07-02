import 'package:chatapp/Constants/Constants.dart';
import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  PageViewItem({super.key, this.image, this.text, this.label});
  final String? image;
  final String? text;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagepath + image!,
            height: 150,
            filterQuality: FilterQuality.high,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              label!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              text!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
