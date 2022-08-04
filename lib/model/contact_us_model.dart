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
  MainContactModel(title: "Bookings Team".toUpperCase(), contact: [
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
    title: 'HR Team'.toUpperCase(),
    contact: [
      ContactUsModel(
          title: '',
          onTap: () {
            sendingMails("hr@xpresshealth");
          },
          icon: Icons.email,
          subTitle: 'hr@xpresshealth'),
      ContactUsModel(
          title: '',
          onTap: () {
            dialCall('+353 12118883');
          },
          icon: Icons.phone,
          subTitle: '+353 12118883'),
    ],
  ),
  MainContactModel(title: 'Payroll Team'.toUpperCase(), contact: [
    ContactUsModel(
        title: '',
        onTap: () {
          sendingMails("payroll@xpresshealth");
        },
        icon: Icons.email,
        subTitle: 'payroll@xpresshealth'),
    ContactUsModel(
        title: '',
        onTap: () {
          dialCall('+35312118883');
        },
        icon: Icons.phone,
        subTitle: '+353 12118883'),
  ]),
  MainContactModel(
    title: 'App technical support'.toUpperCase(),
    contact: [
      ContactUsModel(
          title: '',
          onTap: () {
            sendingMails("app@xpresshealth.ie");
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
  MainContactModel(title: 'Report Medical Negligence or Behaviour'.toUpperCase(), contact: [
    ContactUsModel(
        title: '',
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
  ]),
  MainContactModel(title: "Address".toUpperCase(), contact: [
    ContactUsModel(
        title: '',
        onTap: () {
          launchLink('https://goo.gl/maps/7Mrii3wE9T4JcHC68');
        },
        icon: Icons.location_on,
        subTitle: 'Xpress Health, Unit 47, Lavery Ave, Park West Enterprise Centre, Park West, Dublin, Ireland'),
  ])
];
