import 'package:car_rental/support/customclipper.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Widget senderMessage(
    BuildContext context, String img, String time, String msg) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: neurphicmcontainer(
              context,
              18,
              Container(
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    color: neumorphicColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: getTtile(msg, 12, FontWeight.w400, 'Poppins')),
            ),
          ),
          CustomPaint(painter: CustomShape(neumorphicColor)),
          const SizedBox(
            width: 14,
          ),
          neurphicmcontainer(
              context,
              50,
              Image.asset(
                img,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )),
        ],
      ),
      const SizedBox(
        height: 4,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          getTtile(time, 12, FontWeight.w400, 'Lab Grotesque'),
          const SizedBox(
            width: 65,
          )
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
