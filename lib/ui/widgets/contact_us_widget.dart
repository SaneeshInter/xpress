import 'package:flutter/material.dart';
import '../../Constants/AppColors.dart';
import '../../utils/constants.dart';

class ContactUsWidget extends StatelessWidget {
  String title;
  String subTitle;
  IconData icon;
  Function onTap;

  ContactUsWidget({Key? key, required this.title, required this.subTitle, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      title: Text(
        subTitle,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Constants.colors[6]),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ColoredBox(
          color: Constants.colors[12],
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              icon,
              color: white,
              size: 20,
            ),
          ),
        ),
      ),
      subtitle: Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
      ),
    );
  }
}