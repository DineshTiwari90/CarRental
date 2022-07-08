import 'package:car_rental/Home/bookingSuccessfully.dart';
import 'package:car_rental/Home/cripto.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Payment', 16, FontWeight.w500, 'LabGrotesque'),
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
            bookingInfo(),
            const SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.only( left: 19.5, right: 18.5),
              child: getTtile('Card Details', 14, FontWeight.w500, 'LabGrotesque'),
            ),
            const SizedBox(
              height: 17,
            ),
            addCard(),
            const SizedBox(
              height: 22,
            ),
            makePaymentButton(),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only( left: 19.5, right: 18.5),
              child: getTtile(
                  'Other Payment Method', 14, FontWeight.w500, 'LabGrotesque'),
            ),
            const SizedBox(
              height: 13,
            ),
            otherPaymentButtons(width, 27.93, 'assets/images/applepay.png'),
            const SizedBox(
              height: 13,
            ),
            otherPaymentButtons(width, 36, 'assets/images/paypal.png'),
            const SizedBox(
              height: 13,
            ),
            otherPaymentButtons(width, 25, 'assets/images/samsungpay.png'),
            const SizedBox(
              height: 13,
            ),
            criptoPayment(width),
            const SizedBox(
              height: 111,
            )
          ],
        ),
      ),
    );
  }

  Widget criptoPayment(double width) {
    return Padding(
      padding: const EdgeInsets.only( left: 19.5, right: 18.5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cripto()));
        },
        child: Container(
          height: 50,
          width: width,
          child: neurphicmcontainer(
              8,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/money.png',
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  getTtile('Crypto', 14, FontWeight.w500, 'Roboto')
                ],
              )),
        ),
      ),
    );
  }

  Widget otherPaymentButtons(double width, double height, String img) {
    return Padding(
      padding: const EdgeInsets.only( left: 19.5, right: 18.5),
      child: Container(
          height: 50,
          width: width,
          child: neurphicmcontainer(
              8,
              Container(
                width: 59.6,
                height: height,
                alignment: Alignment.center,
                child: Image.asset(
                  img,
                  height: height,
                ),
              ))),
    );
  }

  Widget makePaymentButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BookingSuccessfully()));
      },
      child: Container(
          padding: const EdgeInsets.only(left: 43, right: 42),
          height: 51.14,
          child: neurphicmcontainer(
              27.5,
              Align(
                alignment: Alignment.center,
                child: getTtile(
                    'Make Payment', 14, FontWeight.w500, 'LabGrotesque'),
              ))),
    );
  }

  Widget addCard() {
    return Padding(
      padding: const EdgeInsets.only( left: 19.5, right: 18.5),
      child: neurphicmcontainer(
          15,
          Padding(
            padding: const EdgeInsets.only(top: 7, left: 7, bottom: 7, right: 7),
            child: Container(
              child: Image.asset('assets/images/card1.png'),
            ),
          )),
    );
  }

  Widget bookingInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 14, left: 19.5, right: 18.5),
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
          const Align(
            alignment: Alignment.bottomCenter,
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
          // shadowLightColor: const Color(0xffFAF9F9),
          color: neumorphicColor),
      child: child,
    );
  }
}
