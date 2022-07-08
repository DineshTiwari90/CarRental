import 'package:car_rental/modal/rideinfomodal.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RideInformation extends StatefulWidget {
  const RideInformation({Key? key}) : super(key: key);

  @override
  State<RideInformation> createState() => _RideInformationState();
}

class _RideInformationState extends State<RideInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title:
            getTtile('Ride Information', 16, FontWeight.w500, 'LabGrotesque'),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/arrow_back.png'))),
            )),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13, left: 18, right: 18),
            child: getTtile(
                'We have some interesting stuff or you below. Please check the links  prior to the ride. Have fun!',
                14,
                FontWeight.w500,
                'LabGrotesque'),
          ),
          const SizedBox(
            height: 29,
          ),
          ListView.separated(
              padding: const EdgeInsets.only(left: 18, right: 18),
              separatorBuilder: (context, _) {
                return const SizedBox(
                  height: 18,
                );
              },
              itemCount: rideInfoList.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                RideInfoModal rideInfoModal =
                    RideInfoModal.fromJson(rideInfoList[index]);
                return Container(
                  width: double.infinity,
                  child: neurphicmcontainer(
                      9,
                      ExpansionTile(
                        title: getTtile(rideInfoModal.title.toString(), 14,
                            FontWeight.w500, 'LabGrotesque'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 13, right: 13, bottom: 22),
                            child: getTtile(
                                rideInfoModal.description.toString(),
                                12,
                                FontWeight.w400,
                                'Poppins'),
                          ),
                        ],
                      )),
                );
              }),
          const SizedBox(
            height: 129,
          )
        ],
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
