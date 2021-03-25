import 'package:flutter/material.dart';

class MessageType {
  //int type ==0 'text', 1== 'image'
  String sender;
  String receiver;
  String content;
  int type;
  int timestamp;

  MessageType(
      {@required this.sender,
      @required this.receiver,
      this.content,
      @required this.type,
      @required this.timestamp});

  MessageType.fromMap(Map<String, dynamic> map) {
    print(map);
    this.sender = map['sender'];
    this.receiver = map['receiver'];
    this.content = map['content'];
    this.type = map['type'];
    this.timestamp = map['timestamp'];
  }
}
