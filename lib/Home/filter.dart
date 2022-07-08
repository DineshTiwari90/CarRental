import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  TextEditingController usd1Controller = TextEditingController();
  TextEditingController usd2Controller = TextEditingController();

  List brandList = [
    {'img': 'assets/images/bwm.png', 'title': 'BMW', 'select': false},
    {'img': 'assets/images/dashimg2.png', 'title': 'Ferrari', 'select': false},
    {'img': 'assets/images/rolls.png', 'title': 'Rolls Royce', 'select': false},
    {'img': 'assets/images/aston.png', 'title': 'Aston Martin', 'select': false}
  ];

  List selectcityList = [
    {'city': 'Dubai', 'isSelect': false},
    {'city': 'Abu Dhabi', 'isSelect': false},
    {'city': 'AI Faqa', 'isSelect': false},
    {'city': 'AI Halah', 'isSelect': false},
    {'city': 'AI Hamriyah', 'isSelect': false},
    {'city': 'Hatta', 'isSelect': false},
  ];

  List discountList = [
    {'dis': '5%', 'isSelect': false},
    {'dis': '10%', 'isSelect': false},
    {'dis': '15%', 'isSelect': false},
    {'dis': '25%', 'isSelect': false}
  ];
  bool viewAll = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Filters', 16, FontWeight.w500, 'LabGrotesque'),
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
            padding: const EdgeInsets.only(top: 12, left: 18, right: 19),
            child: getTtile('Brands', 16, FontWeight.w500, 'LabGrotesque'),
          ),
          buildBrand(),
          const SizedBox(
            height: 12,
          ),
          priceRange(width),
          const SizedBox(
            height: 18,
          ),
          selectDate(width),
          const SizedBox(
            height: 18,
          ),
          buildAvaliabilty(),
          const SizedBox(
            height: 18,
          ),
          selectCity(),
          const SizedBox(
            height: 18,
          ),
          buildDiscount(),
          const SizedBox(
            height: 43,
          ),
          buildButton(),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget buildButton() {
    return Container(
        padding: const EdgeInsets.only(left: 40, right: 45),
        height: 51.14,
        child: neurphicmcontainer(
            27.5,
            Align(
              alignment: Alignment.center,
              child: getTtile('Apply', 14, FontWeight.w500, 'LabGrotesque'),
            )));
  }

  Widget buildBrand() {
    return Container(
      height: 97,
      child: ListView.separated(
          padding:
              const EdgeInsets.only(top: 12, left: 18, right: 18, bottom: 12),
          physics: const ScrollPhysics(),
          separatorBuilder: (context, _) {
            return const SizedBox(
              width: 18,
            );
          },
          itemCount: brandList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  for (int i = 0; i < brandList.length; i++) {
                    if (i == index) {
                      setState(() {
                        brandList[i]['select'] = true;
                      });
                    } else {
                      setState(() {
                        brandList[i]['select'] = false;
                      });
                    }
                  }
                });
              },
              child: Container(
                width: 73,
                height: 73,
                child: neurphicmcontainer(
                    17.34,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        brandList[index]['select'] == true
                            ? Image.asset(
                                'assets/images/check.png',
                                width: 18.9,
                                height: 18.9,
                              )
                            : Container(),
                        Image.asset(
                          brandList[index]['img'],
                          width: 61,
                          height: 34,
                          color:
                              brandList[index]['select'] == true ? red : black,
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        Text(
                          brandList[index]['title'],
                          style: TextStyle(
                              fontSize: 10,
                              color: brandList[index]['select'] == true
                                  ? red
                                  : black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'LabGrotesque'),
                        )
                      ],
                    )),
              ),
            );
          }),
    );
  }

  Widget priceRange(double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 20),
      child: neurphicmcontainer(
          12,
          Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 13, bottom: 13, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    getTtile(
                        'Price Range', 14, FontWeight.w500, 'LabGrotesque'),
                    const SizedBox(
                      width: 7,
                    ),
                    Image.asset(
                      'assets/images/info.png',
                      width: 16,
                      height: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Column(
                  children: [Image.asset('assets/images/pricegraph.png')],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Container(
                      width: width / 2.5,
                      child: textfield(context, '', false, usd1Controller,
                          TextInputType.number, []),
                    ),
                    Flexible(
                      child: Container(
                        width: width / 2,
                        child: textfield(context, '', false, usd2Controller,
                            TextInputType.number, []),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget buildDiscount() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 20),
      child: neurphicmcontainer(
          12,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 17, top: 12),
                child:
                    getTtile('Discounted', 14, FontWeight.w500, 'LabGrotesque'),
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                    padding: const EdgeInsets.only(
                        top: 12, left: 14, right: 10, bottom: 15),
                    separatorBuilder: (context, _) {
                      return const SizedBox(
                        width: 15.02,
                      );
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: discountList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            for (int i = 0; i < discountList.length; i++) {
                              if (i == index) {
                                setState(() {
                                  discountList[i]['isSelect'] = true;
                                });
                              } else {
                                setState(() {
                                  discountList[i]['isSselect'] = false;
                                });
                              }
                            }
                          });
                        },
                        child: Container(
                          // height: 61,
                          width: 66.89,

                          child: neurphicmcontainer(
                              10.89,
                              Align(
                                child: Text(
                                  discountList[index]['dis'],
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: discountList[index]['isSelect'] ==
                                              true
                                          ? red
                                          : black,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'LabGrotesque'),
                                ),
                              )),
                        ),
                      );
                    }),
              )
            ],
          )),
    );
  }

  Widget selectCity() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 20),
      child: neurphicmcontainer(
          12,
          Padding(
            padding:
                const EdgeInsets.only(top: 13, left: 13, right: 12, bottom: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTtile(
                        'Select City', 14, FontWeight.w500, 'LabGrotesque'),
                    InkWell(
                      onTap: () {
                        setState(() {
                          viewAll = true;
                        });
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                            color: red,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'LabGrotesque'),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                GridView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: viewAll == true ? selectcityList.length : 3,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 18,
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            for (int i = 0; i < selectcityList.length; i++) {
                              if (i == index) {
                                setState(() {
                                  selectcityList[i]['isSelect'] = true;
                                });
                              } else {
                                setState(() {
                                  selectcityList[i]['isSelect'] = false;
                                });
                              }
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 20, bottom: 20, right: 5),
                          child: neurphicmcontainer(
                              15,
                              Align(
                                child: Text(
                                  selectcityList[index]['city'],
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'LabGrotesque',
                                      fontWeight: FontWeight.w500,
                                      color: selectcityList[index]
                                                  ['isSelect'] ==
                                              false
                                          ? black
                                          : red),
                                ),
                              )),
                        ),
                      );
                    })
              ],
            ),
          )),
    );
  }

  Widget buildAvaliabilty() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 20),
      child: neurphicmcontainer(
          12,
          Padding(
            padding:
                const EdgeInsets.only(top: 13, left: 11, right: 11, bottom: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTtile('Availability', 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 56,
                        child: neurphicmcontainer(
                            15,
                            Align(
                              child: getTtile('Show All', 12, FontWeight.w500,
                                  'LabGrotesque'),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: Container(
                        height: 56,
                        child: neurphicmcontainer(
                            15,
                            const Align(
                              child: Text(
                                'Available Only',
                                style: TextStyle(
                                    color: red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    fontFamily: 'LabGrotesque'),
                              ),
                            )),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget selectDate(double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 18, right: 20),
      child: neurphicmcontainer(
          12,
          Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 14, right: 5, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTtile('Select Date', 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 19,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTtile(
                            'Start Date', 12, FontWeight.w500, 'LabGrotesque'),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                            width: width / 2.5, child: selectTextField('')),
                      ],
                    ),
                    const SizedBox(
                      width: 16.65,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTtile(
                              'End Date', 12, FontWeight.w500, 'LabGrotesque'),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                              width: width / 2, child: selectTextField('')),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget selectTextField(String hintText) {
    return Neumorphic(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
      style: NeumorphicStyle(
          color: neumorphicColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
          intensity: 1,
          depth: NeumorphicTheme.embossDepth(context)),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
      child: Container(
        alignment: Alignment.center,
        height: 55,
        child: TextFormField(
          readOnly: true,
          autofocus: false,
          cursorColor: Colors.black,
          style: const TextStyle(
              fontFamily: 'LabGrotesque',
              fontSize: 12,
              color: red,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              hintStyle: const TextStyle(
                  fontFamily: 'LabGrotesque',
                  fontSize: 12,
                  color: red,
                  fontWeight: FontWeight.w500),
              hintText: hintText,
              border: InputBorder.none),
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
          depth: NeumorphicTheme.depth(context),
          color: neumorphicColor),
      child: child,
    );
  }
}
