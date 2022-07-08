import 'package:car_rental/modal/allreviewmodal.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AllReivew extends StatefulWidget {
  const AllReivew({Key? key}) : super(key: key);

  @override
  State<AllReivew> createState() => _AllReivewState();
}

class _AllReivewState extends State<AllReivew> {
  List reviewList = ['Most Recent', "Positive First", "Negative First"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile("All Review", 16, FontWeight.w500, 'LabGrotesque'),
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
          reviewOption(),
          const SizedBox(
            height: 16,
          ),
          buildAllReview()
        ],
      ),
    );
  }

  Widget buildAllReview() {
    return Padding(
      padding: const EdgeInsets.only( left: 18, right: 18),
      child: neurphicmcontainer(
          12,
          Padding(
            padding:
                const EdgeInsets.only(top: 14, left: 11, right: 11, bottom: 14),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTtile('All Reviews', 14, FontWeight.w500, 'LabGrotesque'),
                    Container(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/rating.png',
                            width: 11.32,
                            height: 10.88,
                          ),
                          const SizedBox(
                            width: 0.66,
                          ),
                          getTtile('4.3', 12, FontWeight.w500, 'LabGrotesque'),
                          const SizedBox(
                            width: 1,
                          ),
                          getTtile(
                              '(15 reviews)', 12, FontWeight.w500, 'LabGrotesque')
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                ListView.separated(
                    separatorBuilder: (context, _) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: allReviewlist.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      AllReviewModal allReviewModal =
                          AllReviewModal.fromJson(allReviewlist[index]);
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 33,
                            backgroundImage: AssetImage(
                              allReviewModal.img.toString(),
                            ),
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getTtile(allReviewModal.title.toString(), 12,
                                    FontWeight.w400, 'Poppins'),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/rating.png',
                                      width: 12,
                                      height: 12,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    getTtile(allReviewModal.rating.toString(), 12,
                                        FontWeight.w400, 'LabGrotesque'),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const CircleAvatar(
                                      radius: 3,
                                      backgroundColor: Color(0xffC4C4C4),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    getTtile(allReviewModal.time.toString(), 8,
                                        FontWeight.w500, 'LabGrotesque')
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    })
              ],
            ),
          )),
    );
  }

  Widget reviewOption() {
    return Padding(
      padding: const EdgeInsets.only(top: 16,),
      child: Container(
        height: 39,
        padding: EdgeInsets.only(),
        child: ListView.separated(
            separatorBuilder: (context, _) {
              return const SizedBox(
                width: 14,
              );
            },
            itemCount: reviewList.length,
            shrinkWrap: true,
            padding:const EdgeInsets.only(left: 18,right: 18),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 103,
                child: neurphicmcontainer(
                    10,
                    Align(
                      child: getTtile(
                          reviewList[index], 12, FontWeight.w500, 'LabGrotesque'),
                    )),
              );
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
