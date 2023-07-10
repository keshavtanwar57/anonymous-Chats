import 'package:flutter/material.dart';
import 'package:groupchat/utils/constansts.dart';
import 'package:groupchat/utils/custom_message.dart';
import 'package:groupchat/utils/socketIo_server.dart';
import 'package:groupchat/widgets/custom_text_field.dart';
import 'package:groupchat/widgets/user_message_card.dart';
import 'package:lottie/lottie.dart';
import 'package:grouped_list/grouped_list.dart';
import 'dart:async';

TextEditingController _mssgController = new TextEditingController();

List<customMessage> Messages = [];

class GroupChatPage extends StatefulWidget {
  final ChatService chatServiceObject;
  const GroupChatPage({super.key, required this.chatServiceObject});
  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  int len = Messages.length;
  void startPeriodicFunction() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (len != Messages.length) {
        len = Messages.length;
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startPeriodicFunction();
    Messages.clear();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Anonymous Group"),
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          //color: Colors.white,
          child: Center(
              child: Column(
            children: [
              Expanded(
                  child: GroupedListView<customMessage, DateTime>(
                      padding: EdgeInsets.all(8),
                      reverse: true,
                      order: GroupedListOrder.DESC,
                      elements: Messages,
                      useStickyGroupSeparators: true,
                      floatingHeader: true,
                      groupBy: (messages) => DateTime(2022),
                      groupHeaderBuilder: (customMessage messages) =>
                          SizedBox(),
                      itemBuilder: (context, customMessage message) => Align(
                            alignment: message.sender == 'self'
                                ? Alignment.bottomRight
                                : Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 7,
                              ),
                              child: message.sender == 'self'
                                  ? UserMessageCard(
                                      size: size,
                                      message: message,
                                    )
                                  : otherMessageCard(
                                      size: size, message: message),
                            ),
                          ))),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomTextField(
                            controller: _mssgController, hintText: "Type..."),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      FloatingActionButton(
                          backgroundColor: Colors.grey.shade900,
                          onPressed: () {
                            String textData = _mssgController.text;
                            if (!textData.isEmpty) {
                              // function sending data to the server
                              widget.chatServiceObject
                                  .sendDataToServer(textData);
                              customMessage messageData = customMessage(
                                  sender: "self",
                                  data: textData,
                                  Username: kUsername,
                                  userID: userID,
                                  avatarIndex: avatarIndex,
                                  roomId: kroomId);
                              Messages.add(messageData);
                              _mssgController.clear();
                              setState(() {});
                            }
                          },
                          child: Transform.rotate(
                            angle: 90 * 3.1415927 / 180,
                            child: LottieBuilder.network(
                                'https://assets8.lottiefiles.com/packages/lf20_YNqYo4yd8y.json'),
                          ))
                    ],
                  ))
            ],
          )),
        ),
      ),
    );
  }
}
