import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/apis/api.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/utils/validations.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RateThExperience extends StatefulWidget {
  const RateThExperience({Key? key}) : super(key: key);

  @override
  State<RateThExperience> createState() => _RateThExperienceState();
}

class _RateThExperienceState extends State<RateThExperience> {
  double rating = 0;
  TextEditingController reviewController = TextEditingController();

  callAddReviewApi() async {
    var body = json.encode({
      'carId': '62bd7ee620890a598be04419',
      'rating': rating.toString(),
      'review_detail': reviewController.text
    });
    print(body);
    try {
      EasyLoading.show();
      var response = await http.post(
        Uri.parse(baseUrl + addReview),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      log(response.body);
      var dataAll = json.decode(response.body);
      if (dataAll['status'] == true) {
        showInSnackBar(Colors.green, dataAll['message'], context);
        Navigator.pop(context);
        EasyLoading.dismiss();
      } else {
        showInSnackBar(Colors.red, dataAll['message'], context);

        EasyLoading.dismiss();
      }
    } catch (e) {
      print(e.toString());
      EasyLoading.dismiss();
    }
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid').toString();
    authToken = prefs.getString('auth_token').toString();
  }

  String userId = '';
  String authToken = '';

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile(
            "Rate The Experience", 16, FontWeight.w500, 'LabGrotesque'),
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
        padding: const EdgeInsets.only(top: 17, left: 18, right: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              popularRides(
                  'assets/images/dashimg1.png',
                  'Aston Martin',
                  'Vantage',
                  '4.7',
                  '2.9',
                  '7.5',
                  '45',
                  '296',
                  '1200',
                  'assets/images/car_background1.png'),
              const SizedBox(
                height: 18,
              ),
              ratingReview(),
              const SizedBox(
                height: 18,
              ),
              createButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget createButton() {
    return InkWell(
      onTap: () {
        if (rating == 0) {
          EasyLoading.showToast("Add your rating");
        } else if (reviewController.text.isEmpty) {
          EasyLoading.showToast('Add your review message');
        } else {
          callAddReviewApi();
        }
      },
      child: Container(
          padding: const EdgeInsets.only(left: 27, right: 24),
          height: 55.14,
          child: neurphicmcontainer(
              27.58,
              Align(
                alignment: Alignment.center,
                child: getTtile(
                    'Submit Review', 14, FontWeight.w500, 'LabGrotesque'),
              ))),
    );
  }

  Widget ratingReview() {
    return Container(
      width: double.infinity,
      child: neurphicmcontainer(
          12,
          Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 15, right: 16, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTtile(
                    'Ratings & Reviews', 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 17.96,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RatingBar.builder(
                      minRating: 1,
                      updateOnDrag: true,
                      itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            size: 19,
                            color: Colors.orange,
                          ),
                      onRatingUpdate: (update) {
                        setState(() {
                          rating = update;
                        });
                      }),
                ),
                const SizedBox(
                  height: 17,
                ),
                Container(
                  height: 114,
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        lightSource: LightSource.topLeft,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(10)),
                        intensity: 1,
                        depth: NeumorphicTheme.embossDepth(context),
                        color: neumorphicColor),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                    child: TextFormField(
                      controller: reviewController,
                      decoration: const InputDecoration(
                          hintText: "Add Your Reviews...",
                          border: InputBorder.none),
                    ),
                  ),
                )
              ],
            ),
          )),
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
                          Image.asset(
                            'assets/images/rating.png',
                            width: 11.32,
                            height: 10.88,
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
                  height: 52,
                ),
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
                            height: 20,
                          )
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
