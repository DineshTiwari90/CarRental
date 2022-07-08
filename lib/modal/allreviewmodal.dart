import 'package:flutter/material.dart';

class AllReviewModal {
  String? img;
  String? title;
  String? rating;
  String? time;
  AllReviewModal({this.img, this.title, this.rating, this.time});

  AllReviewModal.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    title = json['title'];
    rating = json['rating'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['img'] = img;
    data['title'] = title;
    data['rating'] = rating;
    data['time'] = time;
    return data;
  }
}

List allReviewlist = [
  {
    "img": 'assets/images/dp1.jpg',
    'title':
        "Lorem Ipsum is simply dummy text of theis simply dummy text of the  ",
    'rating': '4',
    'time': 'June 2, 2022'
  },
  {
    "img": 'assets/images/dp1.jpg',
    'title':
        "Lorem Ipsum is simply dummy text of theis simply dummy text of the  ",
    'rating': '5',
    'time': 'June 10, 2022'
  },
  {
    "img": 'assets/images/dp.jpeg',
    'title':
        "Lorem Ipsum is simply dummy text of theis simply dummy text of the  ",
    'rating': '5',
    'time': 'June 12, 2022'
  },
  {
    "img": 'assets/images/dp.jpeg',
    'title':
        "Lorem Ipsum is simply dummy text of theis simply dummy text of the  ",
    'rating': '5',
    'time': 'June 22, 2022'
  },
  {
    "img": 'assets/images/dp1.jpg',
    'title':
        "Lorem Ipsum is simply dummy text of theis simply dummy text of the  ",
    'rating': '4',
    'time': 'June 25, 2022'
  },
];
