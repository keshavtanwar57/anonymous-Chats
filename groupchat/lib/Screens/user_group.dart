// for creating and joining rooms
import 'package:flutter/material.dart';
import 'package:groupchat/main.dart';
import 'package:groupchat/utils/constansts.dart';
import 'package:groupchat/utils/socketIo_server.dart';
import 'package:groupchat/widgets/custom_avatar.dart';
import 'package:groupchat/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../widgets/cutom_button2.dart';

String totalUser = '1';
var uuid = Uuid();

// ignore: must_be_immutable
class UserGroup extends StatefulWidget {
  ChatService? chatServiceObject;
  UserGroup({super.key, required this.chatServiceObject});

  @override
  State<UserGroup> createState() => _UserGroupState();
}

class _UserGroupState extends State<UserGroup> {
  @override
  void initState() {
    userID = uuid.v1();
    chatServiceObject!.socket
        ?.emit('queryEvent', {'param1': 'value1', 'param2': 'value2'});

    chatServiceObject!.socket!.emit('total_client', {});

    chatServiceObject!.socket?.on('totalClientsCount', (data) {
      totalUser = data['TotalClients'];
      print(data);
    });

    chatServiceObject!.socket?.on('queryEvent', (data) {
      print('Online users: $data');
      totalUser = data;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('Group'),
        centerTitle: true,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: size.height * .90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const customAvatar(),
                Text(
                  "Welcome\n$kUsername",
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff9376E0)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Total Participants $totalUser",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                Column(
                  children: [
                    customButton2(
                        text: 'Create',
                        onTap: () {
                          Navigator.pushNamed(context, '/create_group',
                              arguments: widget.chatServiceObject);
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    customButton2(
                        text: 'Join',
                        onTap: () {
                          Navigator.pushNamed(context, '/join_group',
                              arguments: widget.chatServiceObject);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
