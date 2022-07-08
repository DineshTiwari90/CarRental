import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class EditBooking extends StatefulWidget {
  const EditBooking({Key? key}) : super(key: key);

  @override
  State<EditBooking> createState() => _EditBookingState();
}

class _EditBookingState extends State<EditBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Edit Booking', 16, FontWeight.w500, 'LabGrotesque'),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            editPickupLocation(),
            const SizedBox(height: 18),
            dropLocation(),
            const SizedBox(
              height: 18,
            ),
            extendTheRide(),
            const SizedBox(
              height: 18,
            ),
            getinTocuh(),
            const SizedBox(
              height: 32,
            ),
            caccelBookingButton(),
            const SizedBox(
              height: 31.86,
            )
          ],
        ),
      ),
    );
  }

  Widget caccelBookingButton() {
    return InkWell(
      onTap: () {
        cancelBookingBottomSheet();
      },
      child: Container(
          padding: const EdgeInsets.only(left: 42, right: 43),
          height: 51.14,
          child: neurphicmcontainer(
              27.5,
              Align(
                alignment: Alignment.center,
                child: getTtile(
                    'Cancel Booking', 14, FontWeight.w500, 'LabGrotesque'),
              ))),
    );
  }

  Widget getinTocuh() {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 19, right: 19),
      child: neurphicmcontainer(
          9,
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getTtile('Get in touch', 14, FontWeight.w500, 'LabGrotesque'),
                Image.asset(
                  'assets/images/telemarketer.png',
                  width: 18,
                  height: 18,
                )
              ],
            ),
          )),
    );
  }

  Widget extendTheRide() {
    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19),
      child: neurphicmcontainer(
          9,
          Padding(
            padding: const EdgeInsets.only(
                top: 17, left: 13, right: 15, bottom: 21.56),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTtile(
                        'Extend the ride', 14, FontWeight.w500, 'LabGrotesque'),
                    Image.asset(
                      'assets/images/calender.png',
                      width: 20,
                      height: 20,
                    )
                  ],
                ),
                const SizedBox(
                  height: 19,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: Image.asset(
                              'assets/images/calender.png',
                            ),
                          ),
                          const SizedBox(
                            width: 14.6,
                          ),
                          getTtile('17-June-2022', 12, FontWeight.w500,
                              "LabGrotesque"),
                        ],
                      ),
                    ),
                    getTtile('To', 12, FontWeight.w500, 'LabGrotesque'),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: Image.asset(
                              'assets/images/calender.png',
                            ),
                          ),
                          const SizedBox(
                            width: 14.6,
                          ),
                          getTtile('22-June-2022', 12, FontWeight.w500,
                              "LabGrotesque"),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget dropLocation() {
    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19),
      child: neurphicmcontainer(
          9,
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 9, right: 9, bottom: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 122,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/map.png'))),
                ),
                const SizedBox(
                  height: 23,
                ),
                getTtile('Add drop off location', 14, FontWeight.w500,
                    'LabGrotesque'),
                const SizedBox(
                  height: 13,
                ),
                Container(
                    height: 69,
                    child: embossNeurphicm(Align(
                      alignment: Alignment.center,
                      child: getTtile(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
                          12,
                          FontWeight.w400,
                          'Poppins'),
                    ))),
                const SizedBox(
                  height: 18,
                ),
                InkWell(
                    onTap: () {
                      // to do
                    },
                    child: saveButton())
              ],
            ),
          )),
    );
  }

  Widget editPickupLocation() {
    return Padding(
      padding: const EdgeInsets.only(top: 14, left: 19, right: 19),
      child: neurphicmcontainer(
          9,
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 9, right: 9, bottom: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 122,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/map.png'))),
                ),
                const SizedBox(
                  height: 23,
                ),
                getTtile('Edit pick up location', 14, FontWeight.w500,
                    'LabGrotesque'),
                const SizedBox(
                  height: 13,
                ),
                Container(
                    height: 69,
                    child: embossNeurphicm(Align(
                      alignment: Alignment.center,
                      child: getTtile(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
                          12,
                          FontWeight.w400,
                          'Poppins'),
                    ))),
                const SizedBox(
                  height: 18,
                ),
                InkWell(
                    onTap: () {
                      // to do
                    },
                    child: saveButton())
              ],
            ),
          )),
    );
  }

  Widget saveButton() {
    return Container(
      width: 111.66,
      height: 31,
      child: neurphicmcontainer(
          27.5,
          Align(
            alignment: Alignment.center,
            child: getTtile('Save', 14, FontWeight.w500, 'LabGrotesque'),
          )),
    );
  }

  cancelBookingBottomSheet() {
    return showModalBottomSheet(
        backgroundColor: backgroundcolor,
        shape: const RoundedRectangleBorder(
            // <-- SEE HERE
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(35.0),
        )),
        context: context,
        builder: (context) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, left: 18, bottom: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  getTtile(
                      'Cancel Booking', 14, FontWeight.w500, 'LabGrotesque'),
                  const SizedBox(
                    height: 23,
                  ),
                  getTtile('Are you sure you would like to Cancel?', 14,
                      FontWeight.w500, 'LabGrotesque'),
                  const SizedBox(
                    height: 23,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 116,
                        height: 51.14,
                        child: neurphicmcontainer(
                            27.5,
                            Align(
                              child: getTtile(
                                  'No', 14, FontWeight.w500, 'LabGrotesque'),
                            )),
                      ),
                      Container(
                        width: 116,
                        height: 51.14,
                        child: neurphicmcontainer(
                            27.5,
                            Align(
                              child: getTtile(
                                  'Yes', 14, FontWeight.w500, 'LabGrotesque'),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
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

  Neumorphic embossNeurphicm(Widget child) {
    return Neumorphic(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            intensity: 1,
            depth: NeumorphicTheme.embossDepth(context)),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
        child: child);
  }
}
