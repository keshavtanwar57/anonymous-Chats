import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../Screens/group_chat_page.dart';
import 'constansts.dart';
import 'custom_message.dart';

class ChatService {
  IO.Socket? socket;

  void init() {
    socket = IO.io("http://10.0.2.2:3000/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    // socket = IO.io("https://anonymous-hni9.onrender.com/", <String, dynamic>{
    //   "transports": ["websocket"],
    //   "autoConnect": false
    // });

    socket!.connect();

    socket?.onConnect((_) {
      print("connected to frontend");
      socket!.on("serverMssg", (serverResponse) {
        if (serverResponse["userID"] != userID) {
          print(serverResponse);
          Messages.add(customMessage(
            data: serverResponse["data"],
            sender: serverResponse["sender"],
            Username: serverResponse["username"],
            userID: serverResponse["userID"],
            avatarIndex: serverResponse["avatarIndex"],
            roomId: serverResponse["roomId"],
          ));
        }
      });

      //     socket!.on('total_client',(serverResponse){

      // });
    });
  }

  void sendDataToServer(String data) {
    socket!.emit('send_mssg', {
      "sender": "self",
      "data": data,
      "username": kUsername,
      "userID": userID,
      "avatarIndex": avatarIndex,
      "roomId": kroomId
    });
  }

  void createRoom(String roomName) {
    if (socket != null) {
      socket!.emit('create_room', roomName);
    }
  }

  void joinRoom(String roomKey) {
    if (socket != null) {
      socket!.emit('join_room', roomKey);
    }
  }

  void dispose() {
    if (socket != null) {
      socket!.dispose();
    }
  }
}
