import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groupchat/Screens/choose_avatar_page.dart';
import 'package:groupchat/Screens/create_group.dart';
import 'package:groupchat/Screens/join_group.dart';
import 'package:groupchat/Screens/user_group.dart';
import 'package:groupchat/Screens/group_chat_page.dart';
import 'package:groupchat/utils/constansts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:groupchat/utils/socketIo_server.dart';
import 'Screens/home_page.dart';
import 'Screens/app_offline_page..dart';

ChatService? chatServiceObject;

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');
  int? savedAvatarIndex = prefs.getInt('avatarIndex');
  runApp(MyApp(
    username: username,
    savedAvatarIndex: savedAvatarIndex,
  ));
  chatServiceObject = ChatService();
  chatServiceObject!.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String? username;
  final int? savedAvatarIndex;
  const MyApp({super.key, this.username, this.savedAvatarIndex});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String initialPage;
    if (username != null && username!.isNotEmpty) {
      initialPage = '/user_group';
      kUsername = username!;
      if (savedAvatarIndex == null) {
        avatarIndex = 2;
      } else {
        avatarIndex = savedAvatarIndex!;
      }
    } else {
      initialPage = '/home_page';
    }

    // if (checkInternetConnectivity() != true) {
    //   initialPage = '/offline_page';
    // }
    //initialPage = '/home_page';

    return MaterialApp(
      title: 'Group Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(primaryColor: Colors.black, primaryColorDark: Colors.black),
      initialRoute: initialPage,
      routes: {
        '/home_page': (context) => const HomePage(),
        '/group_chat_page': (context) => GroupChatPage(
              chatServiceObject: chatServiceObject!,
            ),
        '/select_avatar': (context) => const selectAvatar(),
        '/user_group': (context) => UserGroup(
              chatServiceObject: chatServiceObject,
            ),
        '/create_group': (context) => createGroup(
              chatServiceObject: chatServiceObject!,
            ),
        '/join_group': (context) => joinGroup(
              chatServiceObject: chatServiceObject!,
            ),
        '/offline_page': (context) => const OfflinePage()
      },
    );
  }
}
