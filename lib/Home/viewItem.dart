import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/Home/selectdatetime.dart';
import 'package:car_rental/apis/api.dart';
import 'package:car_rental/modal/allreviewmodal.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/validations.dart';

class ViewItem extends StatefulWidget {
  String img1;
  String title1;
  String title2;
  String rating;
  String timer;
  String miles;
  String exhaust;
  String speed;
  String price;
  String img2;
  ViewItem(this.img1, this.title1, this.title2, this.rating, this.timer,
      this.miles, this.exhaust, this.speed, this.price, this.img2);
  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  int currentIndex = 0;
  PageController pageController = PageController();

  // API FUNCTIOn
  bool isAddWishlist = false;
  callAddWishlistApi() async {
    var body = json.encode({'car_id': '62bd7ee620890a598be04419'});
    try {
      EasyLoading.show();
      var response = await http.post(
        Uri.parse(baseUrl + addWishlistApi),
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
        isAddWishlist = true;
        setState(() {});
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

  callDeleteWishlishApi() async {
    // change with dynamic id
    var id = '62bd7ee620890a598be04419';
    try {
      EasyLoading.show();
      var response = await http.delete(
        Uri.parse(baseUrl + deleteWishlistApi + id),
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
        isAddWishlist = false;
        setState(() {});
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

  // END FUNCTIOn

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
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List sliderImages = [
    'assets/images/car.png',
    'assets/images/car.png',
    'assets/images/car.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile(widget.title1, 16, FontWeight.w500, 'LabGrotesque'),
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
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            viewInLast('50 Views in the last 24 hrs'),
            sliderView(),
            itemModal('2018'),
            favouriteAndPrice(),
            topFeature('2'),
            description(),
            aboutBooking(),
            technicalSpec(),
            colorTrim(),
            buildReview('4.3', '15 reviews'),
            buildLogo(),
            const SizedBox(
              height: 49,
            )
          ],
        ),
      ),
    );
  }

  Widget technicalSpec() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 27),
      child: neurphicmcontainer(
          15,
          Padding(
            padding: const EdgeInsets.only(top: 3.65, left: 11, bottom: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTtile('Technical Specification', 14, FontWeight.w500,
                    'LabGrotesque'),
                const SizedBox(
                  height: 23.23,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            technicalSpecSeperatewidget(
                                'Power',
                                '440 bhp',
                                'assets/theamimages/tech1.png',
                                'assets/theamimages/techline1.png'),
                            const SizedBox(
                              height: 10,
                            ),
                            technicalSpecSeperatewidget(
                                'Engine',
                                '3.9 Liters 16',
                                'assets/theamimages/tech2.png',
                                'assets/theamimages/techline2.png'),
                            const SizedBox(
                              height: 10,
                            ),
                            technicalSpecSeperatewidget(
                                '0-100 / 0-200',
                                '5.1s / 11.2s',
                                'assets/theamimages/tech3.png',
                                'assets/theamimages/techline2.png'),
                            const SizedBox(
                              height: 10,
                            ),
                            technicalSpecSeperatewidget(
                                'Top Speed',
                                '320 kmh',
                                'assets/theamimages/tech4.png',
                                'assets/theamimages/techline2.png'),
                            const SizedBox(
                              height: 10,
                            ),
                            technicalSpecSeperatewidget(
                                'Transmission',
                                'Automatic',
                                'assets/theamimages/tech5.png',
                                'assets/theamimages/techline2.png'),
                            const SizedBox(
                              height: 10,
                            ),
                            technicalSpecSeperatewidget(
                                'Fuel Consumption',
                                '11.2 Liters',
                                'assets/theamimages/tech6.png',
                                'assets/theamimages/techline2.png'),
                            const SizedBox(
                              height: 10,
                            ),
                            technicalSpecSeperatewidget(
                                'Drivetrain',
                                '4X4',
                                'assets/theamimages/tech7.png',
                                'assets/theamimages/techline4.png')
                          ],
                        ),
                      ),
                    ),
                    // ignore: sized_box_for_whitespace
                    Container(
                        height: 185.61,
                        child: Image.asset(
                          'assets/images/techcar.png',
                          height: 185.61,
                        ))
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget technicalSpecSeperatewidget(
      String title, String subtitle, String img1, String img2) {
    return Container(
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    getTtile(title, 9, FontWeight.w400, 'LabGrotesque'),
                    const SizedBox(
                      height: 6,
                    ),
                    getTtile(subtitle, 12, FontWeight.w700, 'LabGrotesque')
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                child: Image.asset(
                  img1,
                  width: 35,
                  height: 35,
                ),
              ),
            ],
          ),
          Image.asset(
            img2,
            width: 83,
            height: 8.5,
          ),
        ],
      ),
    );
  }

  Widget itemModal(String modal) {
    return Padding(
        padding: const EdgeInsets.only(left: 18, right: 28, top: 27),
        child: neurphicmcontainer(
          15,
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 10, right: 10, bottom: 17),
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
                              widget.img1,
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
                              getTtile(widget.title1, 11.5, FontWeight.w400,
                                  'LabGrotesque'),
                              getTtile('Vantage', 24.5, FontWeight.w700,
                                  'LabGrotesque')
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Container(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Model Year $modal',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: 'LabGrotesque'),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.star_border_purple500_outlined,
                                  size: 15,
                                  color: black,
                                ),
                                const SizedBox(
                                  width: 3.75,
                                ),
                                getTtile(widget.rating, 10.5, FontWeight.w700,
                                    'LabGrotesque'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget createaboutBookingRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getTtile(title, 12, FontWeight.w500, 'LabGrotesque'),
        getTtile(value, 12, FontWeight.w400, 'LabGrotesque')
      ],
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
      child: neurphicmcontainer(
          12,
          Padding(
            padding:
                const EdgeInsets.only(top: 13, left: 10, right: 14, bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTtile("Description", 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 8,
                ),
                getTtile(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has beenthe industry's",
                    12,
                    FontWeight.w400,
                    'LabGrotesque'),
              ],
            ),
          )),
    );
  }

  Widget topFeature(String seat) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
      child: neurphicmcontainer(
          12,
          Padding(
            padding:
                const EdgeInsets.only(top: 13, left: 13, right: 14, bottom: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTtile('Top Features', 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 19,
                ),
                Container(
                  // width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getDetials('0-60', 'assets/images/dashimg8.png',
                          widget.timer, 'sec'),
                      getDetials('1/4 mile', 'assets/images/dashimg10.png',
                          widget.miles, 'sec'),
                      getDetials('Exhaust', 'assets/images/dashimg9.png',
                          widget.exhaust, 'db')
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getDetials(
                          'Power', 'assets/images/dashimg6.png', '510', 'bhp'),
                      getDetials('Speed', 'assets/images/dashimg7.png',
                          widget.speed, 'Kmh'),
                      getDetials(
                          'Seat', 'assets/images/seat.png', seat, 'seater')
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget favouriteAndPrice() {
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
      child: Container(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                !isAddWishlist ? callAddWishlistApi() : callDeleteWishlishApi();
              },
              child: Container(
                  height: 56,
                  width: 56,
                  child: neurphicmcontainer(
                      27.5,
                      !isAddWishlist
                          ? const Icon(
                              Icons.favorite_border,
                              color: black,
                            )
                          : const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ))),
            ),
            Container(
              height: 56,
              width: 56,
              child: neurphicmcontainer(
                  27.5,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        child: Image.asset(
                          'assets/images/sound.png',
                          width: 18,
                          height: 18,
                        ),
                      ),
                      getTtile('Start', 10, FontWeight.w400, 'LabGrotesque'),
                      Container(
                          width: 10,
                          child: const Divider(
                            height: 2,
                            color: black,
                          )),
                      getTtile('Stop', 10, FontWeight.w400, 'LabGrotesque'),
                    ],
                  )),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectDateTime()));
                },
                child: priceButton('1200'))
          ],
        ),
      ),
    );
  }

  Widget aboutBooking() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, top: 18, right: 18),
      child: neurphicmcontainer(
          12,
          Padding(
            padding:
                const EdgeInsets.only(top: 13, left: 13, right: 13, bottom: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTtile("About Booking", 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 20,
                ),
                createaboutBookingRow('Deposit', '50% Deposit Amount'),
                const SizedBox(
                  height: 20,
                ),
                createaboutBookingRow('Price Per Day', "USD 100/ Day"),
                const SizedBox(
                  height: 20,
                ),
                createaboutBookingRow('Mileage Limit', '10 KM')
              ],
            ),
          )),
    );
  }

  Widget colorTrim() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
      child: neurphicmcontainer(
          15,
          Padding(
            padding: const EdgeInsets.only(
                top: 9.41, left: 13, right: 13, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTtile('Color & Trim', 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 12.41,
                ),
                createColorFeatureRowColumn(
                    'assets/theamimages/obsidian.png',
                    "Interior",
                    'Obsidian Black',
                    'assets/theamimages/color.png',
                    "Headlining Colour",
                    '650 bhp'),
                const SizedBox(
                  height: 12,
                ),
                createColorFeatureRowColumn(
                    'assets/theamimages/color.png',
                    "Carpet Color",
                    'Black',
                    'assets/theamimages/color.png',
                    "Seat Colour",
                    'Black'),
                const SizedBox(
                  height: 12,
                ),
                singleCreateColorRowColumn('assets/theamimages/color.png',
                    'Steering Wheel Colour', 'Black'),
                const SizedBox(
                  height: 23,
                ),
                getTtile('Features', 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 18.27,
                ),
                createColorFeatureRowColumn(
                    'assets/theamimages/navigation.png',
                    "Navigation",
                    'GPS / GLONASS',
                    'assets/theamimages/audio.png',
                    "Audio",
                    '130W'),
                const SizedBox(
                  height: 12,
                ),
                createColorFeatureRowColumn(
                    'assets/theamimages/seats.png',
                    "Seats",
                    'Sports / 18 pos.',
                    'assets/theamimages/connectivity.png',
                    "Connectivity",
                    'WiFi / Bluetooth'),
                const SizedBox(
                  height: 12,
                ),
                createColorFeatureRowColumn(
                    'assets/theamimages/multimedia.png',
                    "Multimedia",
                    'Apple Car Play',
                    'assets/theamimages/power.png',
                    "Power",
                    '650 bhp'),
              ],
            ),
          )),
    );
  }

  Widget singleCreateColorRowColumn(
      String img1, String title1, String subtitle1) {
    return Row(
      children: [
        Container(
          height: 35,
          width: 35,
          child: Image.asset(
            img1,
            height: 35,
            width: 35,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTtile(title1, 9, FontWeight.w400, 'LabGrotesque'),
            getTtile(subtitle1, 9, FontWeight.w500, 'LabGrotesque')
          ],
        )
      ],
    );
  }

  Widget createColorFeatureRowColumn(String img1, String title1,
      String subtitle1, String img2, String title2, String subtitle2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Row(
            children: [
              Container(
                height: 35,
                width: 35,
                child: Image.asset(
                  img1,
                  height: 35,
                  width: 35,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTtile(title1, 9, FontWeight.w400, 'LabGrotesque'),
                  getTtile(subtitle1, 9, FontWeight.w700, 'LabGrotesque')
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            child: Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  child: Image.asset(
                    img2,
                    height: 35,
                    width: 35,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTtile(title2, 9, FontWeight.w400, 'LabGrotesque'),
                    getTtile(subtitle2, 9, FontWeight.w500, 'LabGrotesque')
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildReview(String rating, String review) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
      child: neurphicmcontainer(
          15,
          Padding(
            padding: const EdgeInsets.only(
                top: 9, left: 11, right: 9.42, bottom: 13),
            child: Container(
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getTtile('Reviews', 14, FontWeight.w500, 'LabGrotesque'),
                      Container(
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/rating.png',
                              width: 14,
                              height: 14,
                            ),
                            getTtile(
                                rating, 12, FontWeight.w500, 'LabGrotesque'),
                            getTtile('($review)', 12, FontWeight.w500,
                                'LabGrotesque')
                          ],
                        ),
                      )
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
                      itemCount: 3,
                      physics: ScrollPhysics(),
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
                                      getTtile(allReviewModal.rating.toString(),
                                          12, FontWeight.w400, 'LabGrotesque'),
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
                                      getTtile(allReviewModal.time.toString(),
                                          8, FontWeight.w500, 'LabGrotesque')
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
            ),
          )),
    );
  }

  Widget sliderView() {
    return Container(
      height: 220,
      width: double.infinity,
      child: PageView.builder(
          controller: pageController,
          itemCount: sliderImages.length,
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (_, i) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 190,
                      child: Image.asset('assets/images/carroad.jpg'),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 198,
                        width: 297,
                        alignment: Alignment.center,
                        child: Image.asset(
                          sliderImages[i],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      sliderImages.length,
                      (index) => buildDot(index, context),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget priceButton(String price) {
    return Container(
      height: 56,
      width: 191,
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
                  padding: const EdgeInsets.only(left: 5, bottom: 16, top: 16),
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
                Container(
                  width: 25.34,
                  height: 20.67,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/arrow.png',
                    width: 25.34,
                    height: 20.67,
                  ),
                )
              ],
            )),
      ),
    );
  }

  viewInLast(String title) {
    return SizedBox(
      child: Container(
        height: 29,
        width: 155,
        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
        padding: const EdgeInsets.only(left: 9),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: const Color(0xff08161821),
            border: Border.all(color: const Color(0xff08161821)),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: getTtile(title, 12, FontWeight.w400, 'LabGrotesque'),
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

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 4,
      width: currentIndex == index ? 14 : 4,
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: currentIndex == index ? red : const Color(0xffC4C4C4),
      ),
    );
  }

  Widget buildLogo() {
    return Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 27),
        child: neurphicmcontainer(
            15,
            Padding(
              padding: EdgeInsets.only(top: 42, bottom: 9),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 52.46,
                    width: 180,
                  ),
                  const SizedBox(
                    height: 15.54,
                  ),
                  getTtile('KEEPER OF THE KEYS', 12, FontWeight.w400,
                      'LabGrotesque'),
                  const SizedBox(
                    height: 21,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: getTtile('DiMarca Car Rental', 12, FontWeight.w300,
                          'LabGrotesque'),
                    ),
                  )
                ],
              ),
            )));
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
