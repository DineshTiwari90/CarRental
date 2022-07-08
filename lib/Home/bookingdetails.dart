import 'package:car_rental/Home/payment.dart';
import 'package:car_rental/faq/termscondition.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BookindDetails extends StatefulWidget {
  const BookindDetails({Key? key}) : super(key: key);

  @override
  State<BookindDetails> createState() => _BookindDetailsState();
}

class _BookindDetailsState extends State<BookindDetails> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Booking Details', 16, FontWeight.w500, 'LabGrotesque'),
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
        children: [
          bookingRide(
              'assets/images/dashimg1.png',
              'Aston Martin',
              'Vantage',
              '4.2',
              '2.9',
              '7.5',
              '45',
              '296',
              '1200',
              'assets/images/dashimg5.png'),
          const SizedBox(
            height: 18,
          ),
          deliveryLocation(),
          const SizedBox(
            height: 18,
          ),
          bookingDate(),
          const SizedBox(
            height: 18,
          ),
          documents(),
          const SizedBox(
            height: 18,
          ),
          Deposit(),
          const SizedBox(
            height: 18,
          ),
          paymentMethod(width),
          const SizedBox(
            height: 18,
          ),
          bookingInfo(),
          const SizedBox(
            height: 18,
          ),
          tmscond(),
          const SizedBox(
            height: 61,
          ),
          createButton(),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget createButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 43),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Payment()));
        },
        child: Container(
            padding: const EdgeInsets.only(left: 27, right: 24),
            height: 51.14,
            child: neurphicmcontainer(
                27.5,
                Align(
                  alignment: Alignment.center,
                  child: getTtile(
                      'Processed To Pay', 14, FontWeight.w500, 'LabGrotesque'),
                ))),
      ),
    );
  }

  Widget tmscond() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 19,
        right: 19,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isChecked = !isChecked;
              });
            },
            child: isChecked == false
                ? Container(
                    width: 18,
                    height: 18,
                    child: Image.asset(
                      'assets/images/uncheck.png',
                      width: 18,
                      height: 18,
                    ),
                  )
                : Container(
                    width: 18,
                    height: 18,
                    child: Image.asset(
                      'assets/images/checked.png',
                      width: 18,
                      height: 18,
                    ),
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              final response = Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsConditions()))
                  .then((value) {
                setState(() {
                  print(value);
                  isChecked = value == true ? true : false;
                });
              });
            },
            child: const Text(
              'Terms & Conditions',
              style: TextStyle(
                  color: red,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  fontFamily: 'LabGrotesque'),
            ),
          )
        ],
      ),
    );
  }

  Widget bookingInfo() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 19,
        right: 19,
      ),
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

  Widget paymentMethod(double width) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 19,
        right: 19,
      ),
      child: neurphicmcontainer(
          12,
          Padding(
            padding: const EdgeInsets.only(
                top: 15, left: 13, right: 12.24, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTtile('Payment Method', 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 21,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 56,
                      width: width / 2.5,
                      child: neurphicmcontainer(
                          15,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 18.9,
                                height: 16.38,
                                child: Image.asset('assets/images/check.png'),
                              ),
                              const SizedBox(
                                height: 9.62,
                              ),
                              getTtile('Credit/Debit Card', 12, FontWeight.w500,
                                  'LabGrotesque'),
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: neurphicmcontainer(
                            15,
                            SizedBox(
                              width: 86.56,
                              height: 40,
                              child: Image.asset('assets/images/paypal.png'),
                            )),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 2.5,
                      child: neurphicmcontainer(
                          15,
                          SizedBox(
                            width: 75,
                            height: 47,
                            child: Image.asset('assets/images/applepay.png'),
                          )),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: neurphicmcontainer(
                          15,
                          SizedBox(
                            width: 75,
                            height: 47,
                            child: Image.asset('assets/images/samsungpay.png'),
                          )),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget Deposit() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 19,
        right: 19,
      ),
      child: neurphicmcontainer(
        12,
        Padding(
          padding: EdgeInsets.only(top: 15, left: 13, right: 11, bottom: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTtile('Deposit', 14, FontWeight.w500, 'LabGrotesque'),
                  Container(
                    child: Row(
                      children: [
                        const Text(
                          "Learn More",
                          style: TextStyle(
                              color: red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'LabGrotesque'),
                        ),
                        const SizedBox(
                          width: 5.86,
                        ),
                        SizedBox(
                          height: 14,
                          width: 14,
                          child: Image.asset('assets/images/filled.png'),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              getTtile('Make minimum payment, make the booking', 12,
                  FontWeight.w500, 'LabGrotesque'),
              const SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  getTtile('Deposit', 14, FontWeight.w500, 'Muller-Trial'),
                  const SizedBox(
                    width: 18,
                  ),
                  pricebtnWithoutNuerphicm('1200', '/d')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget documents() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 19,
        right: 19,
      ),
      child: neurphicmcontainer(
        12,
        Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 13, right: 13, bottom: 14),
          child: Column(
            children: [
              getTtile('Documents', 14, FontWeight.w500, 'LabGrotesque'),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 57,
                    alignment: Alignment.center,
                    child: neurphicmcontainer(
                        10,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/images/doc.png'),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getTtile('Driving License', 12,
                                        FontWeight.w500, 'LabGrotesque'),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
                                      'View',
                                      style: TextStyle(
                                          color: red,
                                          fontFamily: 'LabGrotesque',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    width: 21,
                  ),
                  Expanded(
                    child: Container(
                      height: 57,
                      alignment: Alignment.center,
                      child: neurphicmcontainer(
                          10,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    alignment: Alignment.center,
                                    child: Image.asset('assets/images/doc.png'),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getTtile('Passport', 12, FontWeight.w500,
                                          'LabGrotesque'),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text(
                                        'View',
                                        style: TextStyle(
                                            color: red,
                                            fontFamily: 'LabGrotesque',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bookingDate() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 19,
        right: 19,
      ),
      child: neurphicmcontainer(
          9,
          Padding(
            padding:
                const EdgeInsets.only(top: 13, left: 12, right: 10, bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTtile(
                        'Booking Date', 14, FontWeight.w500, 'LabGrotesque'),
                    const Text(
                      'Change Date',
                      style: TextStyle(
                          color: red,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'LabGrotesque'),
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

  Widget deliveryLocation() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 19,
        right: 19,
      ),
      child: neurphicmcontainer(
          9,
          Padding(
            padding: const EdgeInsets.only(
                top: 14, left: 13, right: 14, bottom: 14.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.asset('assets/images/map.png'),
                ),
                const SizedBox(
                  height: 19,
                ),
                getTtile(
                    'Delivery Location', 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 15.4,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 19.2,
                      height: 19.2,
                      child: Image.asset('assets/images/tab2.png'),
                    ),
                    const SizedBox(
                      width: 13.4,
                    ),
                    getTtile('Location Lorem Ipsum is simply Abu Dhabi', 12,
                        FontWeight.w500, 'LabGrotesque')
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget bookingRide(
      String img1,
      String title1,
      String title2,
      String rating,
      String timer,
      String miles,
      String exhaust,
      String speed,
      String price,
      String img2) {
    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19, top: 14),
      child: Container(
        child: neurphicmcontainer(
          15,
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset(
                              img1,
                              width: 76,
                              height: 43,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getTtile(title1, 11.5, FontWeight.w400,
                                  'LabGrotesque'),
                              getTtile(
                                  title2, 24.5, FontWeight.w700, 'LabGrotesque')
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_border_purple500_outlined,
                            size: 15,
                            color: black,
                          ),
                          const SizedBox(
                            width: 3.75,
                          ),
                          getTtile(
                              rating, 10.5, FontWeight.w700, 'LabGrotesque'),
                          const SizedBox(
                            width: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getDetials('0-60', 'assets/images/dashimg8.png',
                                    timer, 'sec'),
                                const SizedBox(
                                  width: 15,
                                ),
                                getDetials(
                                    '1/4 mile',
                                    'assets/images/dashimg10.png',
                                    miles,
                                    'sec'),
                                const SizedBox(
                                  width: 15,
                                ),
                                getDetials('Exhaust',
                                    'assets/images/dashimg9.png', exhaust, 'db')
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Container(
                            child: Row(
                              children: [
                                getDetials('Power',
                                    'assets/images/dashimg6.png', '510', 'bhp'),
                                const SizedBox(
                                  width: 11.85,
                                ),
                                getDetials('Speed',
                                    'assets/images/dashimg7.png', speed, 'Kmh')
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 29,
                          ),
                          priceButton(price)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Image.asset(
                          img2,
                          width: 160,
                          // height: 180,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Neumorphic neurphicmcontainer(double radius, Widget child) {
    return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          lightSource: LightSource.topLeft,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(radius)),
          intensity: 1,
          // shadowLightColor: const Color(0xffFAF9F9),
          color: neumorphicColor),
      child: child,
    );
  }

  Widget priceButton(String price) {
    return SizedBox(
      height: 31,
      width: 111,
      child: Neumorphic(
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(27.5)),
            intensity: 1,
            depth: NeumorphicTheme.depth(context)),
        child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
                  child: Row(
                    children: [
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "usd",
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '/d',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/arrow.png',
                  width: 20.43,
                  height: 16.67,
                )
              ],
            )),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  Widget getDetials(String text1, String img, String text2, String text3) {
    return Container(
      child: Column(
        children: [
          getTtile(text1, 7.9, FontWeight.w300, 'LabGrotesque'),
          const SizedBox(
            height: 4.53,
          ),
          Row(
            children: [
              Image.asset(
                img,
                width: 13.5,
                height: 13.5,
              ),
              // Icon(Icons.alarm,size: 10,),
              // icon,
              const SizedBox(
                width: 3.91,
              ),
              getTtile(text2, 12.5, FontWeight.w700, 'LabGrotesque'),
              const SizedBox(
                width: 1,
              ),
              getTtile(text3, 8.3, FontWeight.w300, 'LabGrotesque')
            ],
          ),
        ],
      ),
    );
  }
}
