import 'package:flutter/material.dart';
import 'package:groupchat/utils/constansts.dart';
import 'dart:io';

import 'package:lottie/lottie.dart';

//import 'package:connectivity/connectivity.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

Future<bool> checkInternetConnectivity() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true; // Connected to the internet
    }
  } on SocketException catch (_) {
    return false; // No internet connection
  }
  return false; // No internet connection
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text("Network Error"),
          // LottieBuilder.network(
          //     'https://assets6.lottiefiles.com/packages/lf20_b8rtfk3s.json'),
          ElevatedButton(
              onPressed: () async {
                bool isConnected = await checkInternetConnectivity();
                if (isConnected) {
                  if (kUsername != 'User 1') {
                    Navigator.pushNamed(context, '/home_page');
                  } else {
                    Navigator.pushNamed(context, '/user_group');
                  }
                } else {
                  print("Offline");
                }
              },
              child: Text("Try Again"))
        ]),
      ),
    );
  }
}
