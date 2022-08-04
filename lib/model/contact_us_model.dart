import 'package:flutter/material.dart';

import '../utils/network_utils.dart';

class MainContactModel {
  String title;
  List<ContactUsModel> contact;

  MainContactModel({required this.title, required this.contact});
}

class ContactUsModel {
  String title;
  String subTitle;
  IconData icon;
  Function onTap;

  ContactUsModel({required this.title, required this.subTitle, required this.icon, required this.onTap});
}

List<MainContactModel> list = [
  MainContactModel(title: "Bookings Team", contact: [
    ContactUsModel(
        title: '',
        onTap: () {
          sendingMails("mailto:bookings@xpresshealth.ie?subject=&body=");
        },
        icon: Icons.email,
        subTitle: 'bookings@xpresshealth.ie'),
    ContactUsModel(
        title: '',
        onTap: () {
          dialCall('+35312118883');
        },
        icon: Icons.phone,
        subTitle: '+353 12118883'),
  ]),
  MainContactModel(
    title: 'HR Team',
    contact: [
      ContactUsModel(
          title: '',
          onTap: () {
            sendingMails("mailto:hr@xpresshealth.ie?subject=&body=");
          },
          icon: Icons.email,
          subTitle: 'hr@xpresshealth.ie'),
      ContactUsModel(
          title: '',
          onTap: () {
            dialCall('+353 12118883');
          },
          icon: Icons.phone,
          subTitle: '+353 12118883'),
    ],
  ),
  MainContactModel(title: 'Payroll Team', contact: [
    ContactUsModel(
        title: '',
        onTap: () {

          sendingMails("mailto:payroll@xpresshealth.ie?subject=&body=");
        },
        icon: Icons.email,
        subTitle: 'payroll@xpresshealth.ie'),
    ContactUsModel(
        title: '',
        onTap: () {
          dialCall('+35312118883');
        },
        icon: Icons.phone,
        subTitle: '+353 12118883'),
  ]),
  MainContactModel(
    title: 'App technical support',
    contact: [
      ContactUsModel(
          title: '',
          onTap: () {
            sendingMails("mailto:app@xpresshealth.ie?subject=&body=");

          },
          icon: Icons.email,
          subTitle: 'app@xpresshealth.ie'),
      ContactUsModel(
          title: '',
          onTap: () {
            dialCall('+353 12118883');
          },
          icon: Icons.phone,
          subTitle: '+353 12118883'),
    ],
  ),
  MainContactModel(title: 'Report Medical Negligence or Behaviour', contact: [
    ContactUsModel(
        title: '',
        onTap: () {
          sendingMails("mailto:Victor@xpresshealth.ie?subject=&body=");

        },
        icon: Icons.email,
        subTitle: 'Victor@xpresshealth.ie'),

  ]),






  MainContactModel(title: "Management office", contact: [
    ContactUsModel(
        title: 'Management office',
        onTap: () {
          sendingMails("mailto:CPhilip@xpresshealth.ie?subject=&body=");

        },
        icon: Icons.email,
        subTitle: 'CPhilip@xpresshealth.ie'),
    ContactUsModel(
        title: '',
        onTap: () {
          launchLink('https://goo.gl/maps/7Mrii3wE9T4JcHC68');
        },
        icon: Icons.location_on,
        subTitle: 'Xpress Health, Unit 47, Lavery Ave, Park West Enterprise Centre, Park West, Dublin, Ireland'),
  ])
];
