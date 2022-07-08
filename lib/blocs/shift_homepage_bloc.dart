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

  Stream<UserHomeResponse> get userHomeStream => _userHome.stream;

  fetchUserHomepage(BuildContext context) async {
    if (!await isNetworkAvailable()) {
      showInternetNotAvailable(context);
    }else{
      _visibility.add(true);
      UserHomeResponse list = await _repo.fetchUserHomeResponse(token);
      if (list.response != null&&!_userHome.isClosed) {
          _visibility.add(false);
          _userHome.sink.add(list);
        } else {
        Future.delayed(Duration.zero,(){
          showInternetNotAvailable(context);
        });

      }
    }
  }
  Future<void> showInternetNotAvailable(BuildContext context) async {
    int repo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionFailedScreen()),
    );

    if (repo == 1) {
      Future.delayed(Duration.zero,(){
        fetchUserHomepage(context);
      });

    }
  }

  dispose() {
    _userHome.close();
  }
}

final homepageBloc = ShiftHomepageBloc();
