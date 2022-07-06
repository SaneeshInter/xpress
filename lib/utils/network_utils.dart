import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants/strings.dart';

/// returns true if network is available
Future<bool> isNetworkAvailable() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

/// returns true if connected to mobile
Future<bool> isConnectedToMobile() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult == ConnectivityResult.mobile;
}

/// returns true if connected to wifi
Future<bool> isConnectedToWiFi() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult == ConnectivityResult.wifi;
}

Future<void> dialCall(String number) async =>await sendingMails('tel:$number');
Future<void> launchLink(String url) async =>await sendingMails(url);
Future<void> whatsappCall() async =>await sendingMails('https://wa.me/${Txt.contactWhatspp}');
Future<void> navigateTo(double latitude, double longitude) async =>MapsLauncher.launchCoordinates(latitude, longitude);


sendingMails(String url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}
// sendingMails(String url) async {
//   String? encodeQueryParameters(Map<String, String> params) {
//     return params.entries
//         .map((e) =>
//             '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
//         .join('&');
//   }
//
//   final Uri emailLaunchUri = Uri(
//     scheme: 'mailto',
//     path: url,
//     query:
//         encodeQueryParameters(<String, String>{'subject': 'Xpress health !'}),
//   );
//
//   await launchUrl(emailLaunchUri);
// }
