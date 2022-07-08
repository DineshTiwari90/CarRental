import 'package:car_rental/rides/editbooking.dart';
import 'package:car_rental/rides/rideinformation.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CurrentBooking extends StatefulWidget {
  const CurrentBooking({Key? key}) : super(key: key);

  @override
  State<CurrentBooking> createState() => _CurrentBookingState();
}

class _CurrentBookingState extends State<CurrentBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Current Booking', 16, FontWeight.w500, 'LabGrotesque'),
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
            Container(
              padding: const EdgeInsets.only(top: 15, left: 19, right: 19),
              child: Row(
                children: [
                  neurphicmcontainer(
                    8,
                    Image.asset(
                      'assets/images/location.png',
                      height: 35,
                      width: 35,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  getTtile(
                      'Track Delivery', 12, FontWeight.w500, 'LabGrotesque'),
                ],
              ),
            ),
            Container(
              // height: 198,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/roadcar.png',
                // height: 198,
                // width: 297,
              ),
            ),
            BookingInfo(),
            const SizedBox(
              height: 18,
            ),
            buildRidesInfo(),
            const SizedBox(
              height: 27,
            ),
            createButton(),
            const SizedBox(
              height: 35.86,
            ),
          ],
        ),
      ),
    );
  }

  Widget createButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 43),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EditBooking()));
        },
        child: Container(
            padding: const EdgeInsets.only(left: 27, right: 24),
            height: 51.14,
            child: neurphicmcontainer(
                27.5,
                Align(
                  alignment: Alignment.center,
                  child: getTtile(
                      'Edit Booking', 14, FontWeight.w500, 'LabGrotesque'),
                ))),
      ),
    );
  }

  Widget buildRidesInfo() {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 19, right: 19),
      child: neurphicmcontainer(
          9,
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getTtile(
                    'Rides Information', 14, FontWeight.w500, 'LabGrotesque'),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RideInformation()));
                  },
                  child: const Text(
                    'Explore',
                    style: TextStyle(
                        color: red,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'LabGrotesque',
                        fontSize: 14),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget BookingInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19),
      child: neurphicmcontainer(
          12,
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 13,
                    right: 13,
                  ),
                  child: getTtile(
                      'Booking Info', 14, FontWeight.w500, 'LabGrotesque'),
                ),
                const SizedBox(
                  height: 18,
                ),
                BookinginfoRow("Booking Date", '2 Apr to 4 Apr'),
                const SizedBox(
                  height: 12,
                ),
                BookinginfoRow('Number of Days', '2 Days'),
                const SizedBox(
                  height: 12,
                ),
                BookingInfowithUSd("Pirce Per Day", '2400'),
                const SizedBox(
                  height: 12,
                ),
                BookinginfoRow('Discount', '5%'),
                const SizedBox(
                  height: 12,
                ),
                BookingInfowithUSd("Booking Amount", '2400'),
                const SizedBox(
                  height: 12,
                ),
                BookingInfoDepositAmount(),
                const SizedBox(
                  height: 20,
                ),
                const DottedLine(),
                const SizedBox(
                  height: 10,
                ),
                BookingInfowithUSd("Total Pay", '1200'),
                const SizedBox(
                  height: 10,
                ),
                const DottedLine(),
              ],
            ),
          )),
    );
  }

  Widget BookingInfowithUSd(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 13,
        right: 13,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getTtile(title, 12, FontWeight.w400, 'LabGrotesque'),
          pricebtnWithoutNuerphicm(value, '')
        ],
      ),
    );
  }

  Widget BookingInfoDepositAmount() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 13,
        right: 13,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                getTtile('Desposit', 12, FontWeight.w400, 'LabGrotesque'),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 14,
                  width: 14,
                  child: Image.asset('assets/images/info.png'),
                ),
              ],
            ),
          ),
          pricebtnWithoutNuerphicm('1200', '')
        ],
      ),
    );
  }

  Widget BookinginfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 13,
        right: 13,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getTtile(title, 12, FontWeight.w400, 'LabGrotesque'),
          getTtile(value, 16, FontWeight.w700, 'LabGrotesque'),
        ],
      ),
    );
  }

  Widget pricebtnWithoutNuerphicm(String price, String day) {
    return Container(
      height: 31,
      padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
      child: Row(
        children: [
          const Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "usd",
              style: TextStyle(
                  color: black, fontWeight: FontWeight.w400, fontSize: 10),
            ),
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              day,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
            ),
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
