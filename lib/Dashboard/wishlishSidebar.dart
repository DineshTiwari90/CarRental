import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class WishlistSideBar extends StatefulWidget {
  const WishlistSideBar({Key? key}) : super(key: key);

  @override
  State<WishlistSideBar> createState() => _WishlistSideBarState();
}

class _WishlistSideBarState extends State<WishlistSideBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Wishlist', 16, FontWeight.w500, 'LabGrotesque'),
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
      body: Padding(
        padding: const EdgeInsets.only(
          top: 14,
          right: 19,
          left: 19,
        ),
        child: ListView(
          children: [
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
              height: 20,
            ),
            popularRides(
                'assets/images/dashimg2.png',
                'Aston Martin',
                'Vantage',
                '4.2',
                '2.9',
                '7.5',
                '45',
                '296',
                '1200',
                'assets/images/car_background2.png'),
            const SizedBox(
              height: 20,
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
              height: 10,
            )
          ],
        ),
      ),
    );
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
    return InkWell(
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
                  height: 14,
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
                            priceButton(price),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 160,
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

  Widget priceButton(String price) {
    return Container(
      height: 31,
      width: 111,
      child: Neumorphic(
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(27.5)),
            intensity: 12,
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

  filterSearchWidget(img) {
    return SizedBox(
      width: 38,
      child: Neumorphic(
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            intensity: 1,
            depth: NeumorphicTheme.depth(context)),
        child: Image.asset(
          img,
          width: 24,
          height: 24,
        ),
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
