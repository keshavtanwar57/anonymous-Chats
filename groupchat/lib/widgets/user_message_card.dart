import 'package:flutter/material.dart';
import 'package:groupchat/utils/custom_message.dart';
import 'package:lottie/lottie.dart';
import 'package:groupchat/Screens/choose_avatar_page.dart';

class UserMessageCard extends StatelessWidget {
  final message;
  UserMessageCard({super.key, required this.size, required this.message});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            child: SizedBox(
          width: 20,
        )),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.black12),
          child: LottieBuilder.network(avatarsList[message.avatarIndex]),
        ),
        Card(
            elevation: 8,
            color:
                // Color(0xffa100f2)
                message.sender == 'self'
                    ? Color(0xffa100f2)
                    : Colors.grey.shade900,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: size.width * .80, minWidth: 100),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.Username,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(message.data!),
                    Text(
                      "${DateTime.now().hour}:${DateTime.now().minute}",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

class otherMessageCard extends StatelessWidget {
  final customMessage message;
  otherMessageCard({super.key, required this.size, required this.message});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.black12),
          child: LottieBuilder.network(avatarsList[message.avatarIndex]),
        ),
        Card(
            elevation: 8,
            color: message.sender == 'self'
                ? Colors.greenAccent
                : Colors.grey.shade900,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width * .80),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.Username,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(message.data!),
                    Text(
                      "${DateTime.now().hour}:${DateTime.now().minute}",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            )),
        const Expanded(
            child: SizedBox(
          width: 20,
        )),
      ],
    );
  }
}
