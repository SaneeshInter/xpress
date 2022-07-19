import 'package:flutter/material.dart';

import '../utils/network_utils.dart';

class ContactUsModel{
  String title;
  String subTitle;
  IconData icon;
  Function onTap;

  ContactUsModel({required this.title, required this.subTitle, required this.icon, required this.onTap});
}
List<ContactUsModel> list = [
  ContactUsModel(
      title: 'Bookings Team Mail (24/7)',
      onTap: () {
        sendingMails("mailto:bookings@xpresshealth.ie?subject=&body=");
      },
      icon: Icons.email,
      subTitle: 'bookings@xpresshealth.ie'),
  ContactUsModel(
      title: 'Bookings Team Phone (24/7)',
      onTap: () {
        dialCall('+35312118883');
      },
      icon: Icons.phone,
      subTitle: '+353 12118883 (Press 2)'),
  ContactUsModel(
      title: 'HR Team (Mon-Fri)',
      onTap: () {
        sendingMails("hr@xpresshealth");
      },
      icon: Icons.email,
      subTitle: 'hr@xpresshealth'),
  ContactUsModel(
      title: 'HR Team (Mon-Fri)',
      onTap: () {
        dialCall('+353 12118883');
      },
      icon: Icons.phone,
      subTitle: '+353 12118883 (Press 16)'),
  ContactUsModel(
      title: 'Payroll Team (Mon-Fri)',
      onTap: () {
        sendingMails("payroll@xpresshealth");
      },
      icon: Icons.email,
      subTitle: 'payroll@xpresshealth'),
  ContactUsModel(
      title: 'Payroll Team (Mon-Fri)',
      onTap: () {
        dialCall('+35312118883');
      },
      icon: Icons.phone,
      subTitle: '+353 12118883 (Press 17)'),
  ContactUsModel(
      title: 'App technical support (24/7)',
      onTap: () {
        sendingMails("app@xpresshealth.ie");
      },
      icon: Icons.email,
      subTitle: 'app@xpresshealth.ie'),
  ContactUsModel(
      title: 'App technical support (24/7)',
      onTap: () {
        dialCall('+353 12118883');
      },
      icon: Icons.phone,
      subTitle: '+353 12118883 (Press 18)'),
  ContactUsModel(
      title: 'Report Medical Negligence or Behaviour',
      onTap: () {
        sendingMails("Victor@xpresshealth.ie");
      },
      icon: Icons.email,
      subTitle: 'Victor@xpresshealth.ie'),
  ContactUsModel(
      title: 'Management office',
      onTap: () {
        sendingMails("CPhilip@xpresshealth.ie");
      },
      icon: Icons.email,
      subTitle: 'CPhilip@xpresshealth.ie'),
  ContactUsModel(
      title: 'Address',
      onTap: () {
        launchLink('https://goo.gl/maps/7Mrii3wE9T4JcHC68');
      },
      icon: Icons.location_on,
      subTitle: 'Xpress Health, Unit 47, Lavery Ave, Park West Enterprise Centre, Park West, Dublin, Ireland'),
];