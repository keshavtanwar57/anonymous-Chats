import 'package:flutter/material.dart';
import 'package:groupchat/Screens/choose_avatar_page.dart';
import 'package:groupchat/utils/constansts.dart';
import 'package:lottie/lottie.dart';

class customAvatar extends StatefulWidget {
  const customAvatar({super.key});

  @override
  State<customAvatar> createState() => _customAvatarState();
}

class _customAvatarState extends State<customAvatar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/select_avatar');
        setState(() {});
      },
      child: Container(
        height: size.height * .23,
        width: size.height * .23,
        child: Stack(
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              //color: Colors.white,
              child: LottieBuilder.network(avatarsList[avatarIndex]),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home_page');
                  },
                  child: Icon(Icons.edit),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
