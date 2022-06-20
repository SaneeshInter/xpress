import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../model/user_home_response.dart';

import '../resources/respository.dart';
import '../ui/error/ConnectionFailedScreen.dart';
import '../utils/network_utils.dart';

class ShiftHomepageBloc {
  double? currentPage = 0;
  bool visibility = false;
  int devicePixelRatio = 3;
  int perPageItem = 3;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  var token;
  var shiftDetails;
  final _repo = Repository();
  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;
  final _userHome = PublishSubject<UserHomeResponse>();

  Stream<UserHomeResponse> get userhomeStream => _userHome.stream;

  fetchUserHomepage(BuildContext context) async {
    if (await isNetworkAvailable()) {
      _visibility.add(true);
      UserHomeResponse list = await _repo.fetchUserHomeResponse(token);

      if (list.response != null) {
        if (!_userHome.isClosed) {
          _visibility.add(false);
          _userHome.sink.add(list);
        } else {
          showInternetNotAvailable(context);
        }
      } else {
        showInternetNotAvailable(context);
      }
    }else{
      showInternetNotAvailable(context);
    }
  }
  Future<void> showInternetNotAvailable(BuildContext context) async {
    int repo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionFailedScreen()),
    );

    if (repo == 1) {
      fetchUserHomepage(context);
    }
  }

  dispose() {
    _userHome.close();
  }
}

final homepageBloc = ShiftHomepageBloc();
