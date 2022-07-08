import 'package:car_rental/utils/constants.dart';
import 'package:flutter/material.dart';

Widget getTtile(
    String title, double fontsize, FontWeight fontWeight, String fontfaily) {
  return Text(
    title,
    style: TextStyle(
        fontFamily: fontfaily,
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: black),
  );
}
