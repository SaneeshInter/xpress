import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/sharedPrefKeys.dart';

class TokenProvider {
  Future<String?> getToken() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    String? token = shdPre.getString(SharedPrefKey.AUTH_TOKEN);
    return token;
  }  Future<String?> getUserId() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    String? token = shdPre.getInt(SharedPrefKey.USER_TYPE).toString();
    return token;
  }
}
