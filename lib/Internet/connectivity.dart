import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:jaldindi/Auth/auth_service.dart';

import 'no_internet.dart';

checkTheConnectivity() {
  return StreamBuilder(
    stream: Connectivity().onConnectivityChanged,
    builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
      return snapshot.data == ConnectivityResult.mobile ||
              snapshot.data == ConnectivityResult.wifi
          ? AuthService().handleAuthState()
          : const NoInternet();
    },
  );
}
