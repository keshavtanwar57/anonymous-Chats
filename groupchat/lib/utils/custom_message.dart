class customMessage {
  String Username;
  String sender = 'self';
  String? data;
  String? userID;
  int avatarIndex;
  String roomId;

  customMessage(
      {required this.data,
      required this.sender,
      required this.Username,
      required this.userID,
      required this.avatarIndex,
      required this.roomId});
}
