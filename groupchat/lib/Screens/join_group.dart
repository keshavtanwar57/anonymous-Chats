import 'package:flutter/material.dart';
import 'package:groupchat/utils/constansts.dart';
import 'package:groupchat/widgets/custom_button.dart';
import 'package:groupchat/widgets/custom_text_field.dart';
import 'package:groupchat/utils/socketIo_server.dart';
import 'package:lottie/lottie.dart';

import '../widgets/cutom_button2.dart';

TextEditingController _groupIdController = TextEditingController();

class joinGroup extends StatefulWidget {
  final ChatService chatServiceObject;
  joinGroup({required this.chatServiceObject});

  @override
  State<joinGroup> createState() => _joinGroupState();
}

class _joinGroupState extends State<joinGroup> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Join Group",
          ),
          centerTitle: true,
        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset('assets/friends.json'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                    controller: _groupIdController, hintText: "Enter Room Id"),
              ),
              const SizedBox(
                height: 30,
              ),
              customButton2(
                  text: 'Join',
                  onTap: () {
                    String roomId = _groupIdController.text;
                    bool tempvalidkey = false;
                    // widget.chatServiceObject.socket
                    //     ?.emit('validRoom', {'Key': roomId});
                    // widget.chatServiceObject.socket?.on('validRoomKey', (data) {
                    //   print(data['validKey']);
                    //   validkey = data['validKey'];
                    // });

                    if (tempvalidkey != false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid Room Id'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      try {
                        kroomId = roomId;
                        widget.chatServiceObject.joinRoom(roomId);
                        Navigator.pushNamed(context, '/group_chat_page');
                        _groupIdController.clear();
                      } catch (exception) {
                        print("try again");
                      }
                    }
                  }),
            ],
          ),
        ));
  }
}
