import 'package:flutter/material.dart';
import 'package:groupchat/main.dart';
import 'package:groupchat/utils/constansts.dart';
import 'package:groupchat/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/socketIo_server.dart';
import '../widgets/cutom_button2.dart';

var uuid = const Uuid();

class createGroup extends StatefulWidget {
  final ChatService chatServiceObject;
  const createGroup({super.key, required this.chatServiceObject});

  @override
  State<createGroup> createState() => _createGroupState();
}

class _createGroupState extends State<createGroup> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String GroupID = uuid.v1().substring(0, 6);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Create Group",
          ),
          centerTitle: true,
        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: LottieBuilder.asset('assets/friends.json'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  GroupID,
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff9376E0)),
                ),
              ),
              SizedBox(
                height: size.height * .20,
              ),
              customButton2(
                  text: 'Copy Id',
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: GroupID));
                    Fluttertoast.showToast(
                      msg: 'Copied!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              customButton2(
                  text: 'Create',
                  onTap: () {
                    kroomId = GroupID;
                    chatServiceObject!.createRoom(GroupID);
                    Navigator.pushNamed(context, '/group_chat_page');
                  }),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
