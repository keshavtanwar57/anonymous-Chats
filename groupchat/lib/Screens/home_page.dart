import 'package:flutter/material.dart';
import 'package:groupchat/utils/constansts.dart';
import 'package:groupchat/widgets/custom_avatar.dart';
import 'package:groupchat/widgets/custom_button.dart';
import 'package:groupchat/widgets/custom_text_field.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

TextEditingController _nameController = new TextEditingController();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    print("Init Called");
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anonymous Chats"),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        //color: Colors.white54,
        child: Center(
            child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: size.height * .65, maxWidth: size.width * .80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const customAvatar(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                    controller: _nameController, hintText: "Enter Your Name"),
              ),
              customButton(
                text: "arrow",
                onTap: () async {
                  kUsername = _nameController.text;
                  if (kUsername.length > 3) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('username', kUsername);

                    Navigator.pushNamed(context, '/user_group');
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Minimun unsername length is 4.',
                      toastLength: Toast
                          .LENGTH_SHORT, // Duration for which the toast is shown
                      gravity:
                          ToastGravity.BOTTOM, // Position of the toast message
                      backgroundColor:
                          Colors.grey[800], // Background color of the toast
                      textColor: Colors.white, // Text color of the toast
                    );
                  }
                },
                height: 70,
                width: 70,
                isIcon: true,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
