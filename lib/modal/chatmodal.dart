import 'package:flutter/material.dart';

class ChatModal {
  String? img;
  String? msg;
  String? time;
  String? messageType;
  ChatModal({this.img, this.msg, this.time, this.messageType});

  ChatModal.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    msg = json['msg'];
    time = json['time'];
    messageType = json['messageType'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['img'] = img;
    data['msg'] = msg;
    data['time'] = time;
    data['messageType'] = messageType;
    return data;
  }
}

List chatMessage = [
  {
    "img": 'assets/images/dp1.jpg',
    'msg':
        "Lorem Ipsum is simply dummy text of theis simply dummy text of the  ",
    'time': '09:00 PM',
    'messageType': 'receiver'
  },
  {
    "img": 'assets/images/dp.jpeg',
    'msg': "Lorem Ipsum is simply",
    'time': '02:00 AM',
    'messageType': 'sender'
  },
];
