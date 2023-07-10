// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:groupchat/utils/constansts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

String avatarLink =
    "https://assets4.lottiefiles.com/packages/lf20_qjkoks0z.json";

class selectAvatar extends StatefulWidget {
  const selectAvatar({super.key});

  @override
  State<selectAvatar> createState() => _selectAvatarState();
}

List<String> avatarsList = [
  'https://assets4.lottiefiles.com/packages/lf20_zUShxQMjqI.json',
  'https://assets4.lottiefiles.com/packages/lf20_gatzs89r.json',
  'https://assets4.lottiefiles.com/packages/lf20_riok2joc.json',
  'https://assets4.lottiefiles.com/packages/lf20_juote5w5.json',
  'https://assets4.lottiefiles.com/packages/lf20_qjkoks0z.json',
  'https://assets4.lottiefiles.com/packages/lf20_c9hh3d5z.json',
  'https://assets9.lottiefiles.com/packages/lf20_urr8jb9p.json',
  'https://assets9.lottiefiles.com/packages/lf20_rmpmxft3.json',
  'https://assets9.lottiefiles.com/packages/lf20_llpnmgts.json',
  'https://assets9.lottiefiles.com/packages/lf20_sovfbcuo.json',
  'https://assets9.lottiefiles.com/packages/lf20_x6wwkwp2.json',
];

class _selectAvatarState extends State<selectAvatar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Avatar'),
        centerTitle: true,
      ),
      body: Container(
          child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            var item = avatarsList[index];
            return InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                avatarLink = item;
                avatarIndex = index;
                await prefs.setInt('avatarIndex', avatarIndex);
                setState(() {});
                Navigator.pop(context);
                setState(() {});
              },
              child: Card(
                child: LottieBuilder.network(item),
              ),
            );
          },
          itemCount: avatarsList.length, // Total number of items in the list
        ),
      )),
    );
  }
}
