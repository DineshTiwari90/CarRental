import 'package:car_rental/rides/allReview.dart';
import 'package:car_rental/rides/currentbooking.dart';
import 'package:car_rental/rides/ratethexperience.dart';
import 'package:car_rental/rides/rideinformation.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Rides extends StatefulWidget {
  const Rides({Key? key}) : super(key: key);

  @override
  State<Rides> createState() => _RidesState();
}

class _RidesState extends State<Rides> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 18, right: 18),
            child: getTtile('Current Booking', 14, FontWeight.w500, 'LabGrotesque'),
          ),
          const SizedBox(
            height: 19,
          ),
          popularRides(
              'assets/images/dashimg1.png',
              'Aston Martin',
              'Vantage',
              '4.2',
              '2.9',
              '7.5',
              '45',
              '296',
              '1200',
              'assets/images/car_background1.png'),
          const SizedBox(
            height: 18,
          ),
          buildRidesInfo(),
          const SizedBox(
            height: 18,
          ),
          placeTovisit('Burj Khalifa',
              'The Burj Khalifa, known as the Burj Dubai prior to its inauguration in 2010, is a skyscraper in Dubai, United Arab Emirates'),
          const SizedBox(
            height: 17,
          ),
          Padding(
            padding: const EdgeInsets.only( left: 18, right: 18),
            child: getTtile(
                'Old Booking History', 14, FontWeight.w500, 'LabGrotesque'),
          ),
          const SizedBox(
            height: 19,
          ),
          bookingHistry(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget bookingHistry() {
    return Padding(
      padding: const EdgeInsets.only( left: 18, right: 18),
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 15,
            );
          },
          shrinkWrap: true,
          itemCount: 3,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            return historyRides('assets/images/dashimg1.png', 'Aston Martin',
                'Vantage', '4.2', 'assets/images/car_background1.png', index);
          }),
    );
  }

  Widget placeTovisit(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only( left: 18, right: 18),
      child: neurphicmcontainer(
          15,
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
              left: 13,
              right: 40,
              bottom: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTtile('Place To Visit', 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 15,
                ),
                getTtile(title, 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 8,
                ),
                getTtile(subtitle, 10, FontWeight.w400, 'LabGrotesque')
              ],
            ),
          )),
    );
  }

  Widget buildRidesInfo() {
    return Padding(
      padding: const EdgeInsets.only( left: 18, right: 18),
      child: Container(
        height: 50,
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
      ),
    );
  }

  Widget historyRides(String img1, String title1, String title2, String rating,
      String img2, int index) {
    return neurphicmcontainer(
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
                            getTtile(
                                title1, 11.5, FontWeight.w400, 'LabGrotesque'),
                            getTtile(
                                title2, 24.5, FontWeight.w700, 'LabGrotesque')
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 13),
                    child: index == 2
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RateThExperience()));
                            },
                            child: const Text(
                              'Rate The Experience',
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'LabGrotesque',
                                  color: red),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AllReivew()));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/rating.png',
                                  width: 11.32,
                                  height: 10.88,
                                ),
                                const SizedBox(
                                  width: 3.75,
                                ),
                                getTtile(rating, 10.5, FontWeight.w700,
                                    'LabGrotesque'),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTtile(
                            'Book Again', 12, FontWeight.w500, 'LabGrotesque'),
                        const SizedBox(
                          height: 11,
                        ),
                        priceButton('1200')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      // height: 95,
                      width: double.infinity,
                      child: Image.asset(
                        img2,
                        width: 160,
                        // height: 95,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget popularRides(
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
      padding: const EdgeInsets.only( left: 18, right: 18),
      child: InkWell(
        onTap: () {},
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
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: 180,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getDetials(
                            '0-60', 'assets/images/dashimg8.png', timer, 'sec'),
                        const SizedBox(
                          width: 15,
                        ),
                        getDetials('1/4 mile', 'assets/images/dashimg10.png',
                            miles, 'sec'),
                        const SizedBox(
                          width: 15,
                        ),
                        getDetials('Exhaust', 'assets/images/dashimg9.png',
                            exhaust, 'db')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14.85,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    getDetials(
                                        'Power',
                                        'assets/images/dashimg6.png',
                                        '510',
                                        'bhp'),
                                    const SizedBox(
                                      width: 11.85,
                                    ),
                                    getDetials(
                                        'Speed',
                                        'assets/images/dashimg7.png',
                                        speed,
                                        'Kmh')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 26,
                              ),
                              buildTrack(),
                              const SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Image.asset(
                          img2,
                          width: 160,
                          // height: 180,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTrack() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CurrentBooking()));
      },
      child: Container(
        width: 111.66,
        height: 31,
        child: neurphicmcontainer(
            35,
            Align(
                alignment: Alignment.center,
                child: getTtile(
                    'Track Delivery', 12, FontWeight.w500, 'LabGrotesque'))),
      ),
    );
  }

  Widget priceButton(String price) {
    return Container(
      height: 31,
      width: 111,
      child: neurphicmcontainer(
        27.5,
        Align(
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
