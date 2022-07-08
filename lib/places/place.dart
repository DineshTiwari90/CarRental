import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({Key? key}) : super(key: key);

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  List placeInfoList = [
    {
      "name": 'Abu Dhabi',
      "info":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    },
    {
      "name": 'Abu Dhabi',
      "info":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    },
    {
      "name": 'Abu Dhabi',
      "info":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 18, right: 18),
        child: ListView.separated(
            separatorBuilder: (context, _) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount: placeInfoList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return neurphicmcontainer(
                  9,
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 17, left: 13, right: 13, bottom: 34),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTtile(placeInfoList[index]['name'], 14,
                            FontWeight.w500, 'LabGrotesque'),
                        const SizedBox(
                          height: 18,
                        ),
                        getTtile(placeInfoList[index]['info'], 12,
                            FontWeight.w400, 'Poppins')
                      ],
                    ),
                  ));
            }),
      ),
    );
  }

  Neumorphic neurphicmcontainer(double radius, Widget child) {
    return Neumorphic(
      style: NeumorphicStyle(
          lightSource: LightSource.topLeft,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(radius)),
          intensity: 1,
          depth: NeumorphicTheme.depth(context),
          // shadowLightColor: const Color(0xffFAF9F9),
          color: neumorphicColor),
      child: child,
    );
  }
}
