import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/sharedPrefKeys.dart';

class TokenProvider {
  Future<String?> getToken() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    String? token = shdPre.getString(SharedPrefKey.AUTH_TOKEN);
    return token;
  }
}
