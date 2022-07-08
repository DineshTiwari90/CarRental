import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BookingSuccessfully extends StatefulWidget {
  const BookingSuccessfully({Key? key}) : super(key: key);

  @override
  State<BookingSuccessfully> createState() => _BookingSuccessfullyState();
}

class _BookingSuccessfullyState extends State<BookingSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 19, right: 19, top: 74),
              child: Container(
                width: 297,
                height: 198,
                child: Image.asset('assets/images/car.png'),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            getTtile(
                'Booking Successfully', 16, FontWeight.w500, 'LabGrotesque'),
            const SizedBox(
              height: 25,
            ),
            bookingInfo(),
            const SizedBox(
              height: 60,
            ),
            Container(
              width: 62,
              height: 62,
              child: Image.asset(
                'assets/images/success.png',
                width: 62,
                height: 62,
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }

  Widget bookingInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19, ),
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
      padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
      child: Row(
        children: [
          Column(
            children: const[
               SizedBox(height: 8,),
               Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "usd",
                  style: TextStyle(
                      color: black, fontWeight: FontWeight.w400, fontSize: 10),
                ),
              ),
            ],
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              day,
              style:const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
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
          // shadowLightColor: const Color(0xffFAF9F9),
          color: neumorphicColor),
      child: child,
    );
  }
}
