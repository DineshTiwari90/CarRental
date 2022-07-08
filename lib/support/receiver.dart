import 'package:car_rental/support/customclipper.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Widget receiverMessage(
    BuildContext context, String img, String time, String msg) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          neurphicmcontainer(
              context,
              50,
              Image.asset(
                img,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            width: 14,
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: CustomPaint(
              painter: CustomShape(neumorphicColor),
            ),
          ),
          Flexible(
            child: neurphicmcontainer(
              context,
              15,
              Container(
                  // height: 50,
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    color: neumorphicColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: getTtile(msg, 12, FontWeight.w400, 'Poppins')),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 4,
      ),
      Row(
        children: [
          const SizedBox(
            width: 65,
          ),
          getTtile(time, 12, FontWeight.w400, 'Lab Grotesque')
        ],
      )
    ],
  );
}

Neumorphic neurphicmcontainer(
    BuildContext context, double radius, Widget child) {
  return Neumorphic(
    style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        lightSource: LightSource.topLeft,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(radius)),
        intensity: 1,
        depth: NeumorphicTheme.depth(context),
        color: neumorphicColor),
    child: child,
  );
}
