import 'package:chatapp/Constants/Constants.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {super.key,
      this.icon,
      this.title,
      this.onTap,
      this.istop,
      required this.isfreinds});
  final IconData? icon;
  final String? title;
  final VoidCallback? onTap;
  final bool? istop;
  final bool isfreinds;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Padding(
        padding: EdgeInsets.only(right: 30),
        child: isfreinds == true
            ? Image.asset(
                imagepath + 'fr.png',
                height: 30,
                filterQuality: FilterQuality.high,
                color: const Color.fromRGBO(158, 158, 158, 1),
              )
            : Icon(
                icon,
                size: 30,
                color: istop == true ? Colors.indigo : Colors.grey,
              ),
      ),
      title: Text(
        title!,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: istop == true ? Colors.indigo : Colors.grey,
        ),
      ),
    );
  }
}
