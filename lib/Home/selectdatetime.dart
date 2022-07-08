import 'package:car_rental/Signup/drivinglicence.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/utils/customdatetime.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class SelectDateTime extends StatefulWidget {
  const SelectDateTime({Key? key}) : super(key: key);

  @override
  State<SelectDateTime> createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final TextEditingController pickUpController = TextEditingController();
  TextEditingController completeAddressController = TextEditingController();
  TextEditingController reachAddressController = TextEditingController();

  bool value = false;

  int currentIndex = 0;

  PageController pageController = PageController();
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title:
            getTtile('Select Date & Time', 16, FontWeight.w500, 'LabGrotesque'),
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
          selectDateTime(width),
          const SizedBox(
            height: 18,
          ),
          details(),
          const SizedBox(
            height: 18,
          ),
          createLocation(),
          const SizedBox(
            height: 28,
          ),
          continueButton(),
          const SizedBox(
            height: 34.42,
          )
        ],
      ),
    );
  }

  Widget continueButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 43),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DrivingLicence("selectdatetime", '')));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Container(
            height: 55.58,
            width: 290,
            child: Neumorphic(
              style: NeumorphicStyle(
                  color: neumorphicColor,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(27.5)),
                  intensity: 1,
                  depth: NeumorphicTheme.depth(context)),
              child: Align(
                  alignment: Alignment.center,
                  child: getTtile(
                      'Continue', 14, FontWeight.w500, 'LabGrotesque')),
            ),
          ),
        ),
      ),
    );
  }

  Widget selectDateTime(double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 18, right: 18),
      child: Container(
        child: Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              lightSource: LightSource.topLeft,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              intensity: 1,
              color: neumorphicColor),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 18, left: 13, right: 12.63, bottom: 17),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTtile(
                            'Start Date', 12, FontWeight.w500, 'LabGrotesque'),
                        const SizedBox(
                          height: 13,
                        ),
                        Container(
                            width: width / 2.5,
                            child: InkWell(
                                onTap: () {},
                                child: datetimeTextField(startController, () {
                                  // customDatePicker();
                                }))),
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
                            height: 13,
                          ),
                          Container(
                              width: width / 2.5,
                              child: InkWell(
                                  onTap: () {},
                                  child: datetimeTextField(startController, () {
                                    pickDate(context);
                                  }))),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width / 2.5,
                      child: getTtile(
                          'Pick up Time', 12, FontWeight.w500, 'LabGrotesque'),
                    ),
                    const SizedBox(
                      width: 16.65,
                    ),
                    Flexible(
                      child: Container(
                        width: width / 2,
                        child: datetimeTextField(pickUpController, () {
                          customTimePicker();
                        }),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget details() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            lightSource: LightSource.topLeft,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            intensity: 1,
            color: neumorphicColor),
        child: Padding(
          padding: const EdgeInsets.only(top: 14, left: 12, right: 17),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            getTtile('Details', 14, FontWeight.w500, 'LabGrotesque'),
            const SizedBox(
              height: 19,
            ),
            createDetialsData(),
          ]),
        ),
      ),
    );
  }

  Widget createDetialsData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getTtile('Selected Date', 12, FontWeight.w400, 'LabGrotesque'),
              const SizedBox(
                height: 12,
              ),
              getTtile(
                  'Selected Pick Time', 12, FontWeight.w400, 'LabGrotesque'),
              const SizedBox(
                height: 12,
              ),
              getTtile('Number Of Day', 12, FontWeight.w400, 'LabGrotesque'),
              const SizedBox(
                height: 12,
              ),
              getTtile('Total Cost', 12, FontWeight.w400, 'LabGrotesque'),
            ],
          ),
        ),
        Flexible(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTtile('2,April 2021 To 4,April 2021', 12, FontWeight.w500,
                    'LabGrotesque'),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  height: 12,
                ),
                getTtile('12:00 PM', 12, FontWeight.w400, 'LabGrotesque'),
                const SizedBox(
                  height: 12,
                ),
                getTtile('2 Day', 12, FontWeight.w400, 'LabGrotesque'),
                const SizedBox(
                  height: 12,
                ),
                createUSDUi('2400'),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget createLocation() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Container(
        child: neumorphicContainer(
          Padding(
            padding:
                const EdgeInsets.only(top: 13, left: 12, right: 12, bottom: 28),
            child: Column(
              children: [
                Container(
                  child: Image.asset('assets/images/map.png'),
                ),
                const SizedBox(
                  height: 17,
                ),
                neumorphicContainer(Padding(
                  padding: const EdgeInsets.only(top: 14, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTtile('Delivery Location', 14, FontWeight.w500,
                          'LabGrotesque'),
                      const SizedBox(
                        height: 10,
                      ),
                      locationTextfield(),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        'For pickup location the user will be charged extra amount',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'LabGrotesque',
                            fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      getTtile('Complete Address', 12, FontWeight.w500,
                          'LabGrotesque'),
                      const SizedBox(
                        height: 7,
                      ),
                      textfield(context, '', false, completeAddressController,
                          TextInputType.streetAddress, []),
                      const SizedBox(
                        height: 17,
                      ),
                      getTtile(
                          'How To Reach', 12, FontWeight.w500, 'LabGrotesque'),
                      const SizedBox(
                        height: 7,
                      ),
                      textfield(context, '', false, reachAddressController,
                          TextInputType.streetAddress, []),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  locationTextfield() {
    return Neumorphic(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
      style: NeumorphicStyle(
          color: neumorphicColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
          intensity: 1,
          depth: NeumorphicTheme.embossDepth(context)),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Container(
              width: 18,
              height: 18,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/tab2.png',
                height: 18,
                width: 18,
              ),
            ),
            hintText: '',
            hintStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'LabGrotesque')),
      ),
    );
  }

  Container neumorphicContainer(Widget child) {
    return Container(
      width: double.infinity,
      child: Neumorphic(
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            intensity: 1,
            depth: NeumorphicTheme.depth(context)),
        child: child,
      ),
    );
  }

  Widget createUSDUi(String price) {
    return Container(
      padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
      child: Row(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: const [
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "usd",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        fontFamily: 'LabGrotesque'),
                  ),
                ],
              )),
          Text(
            price,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFamily: 'LabGrotesque'),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Column(
                children: const [
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    '/d',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'LabGrotesque'),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget datetimeTextField(TextEditingController controller, Function() onTap) {
    return Neumorphic(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
      style: NeumorphicStyle(
          color: neumorphicColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
          intensity: 1,
          depth: NeumorphicTheme.embossDepth(context)),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Container(
        alignment: Alignment.center,
        height: 48,
        child: TextFormField(
          onTap: onTap,
          readOnly: true,
          controller: controller,
          autofocus: false,
          cursorColor: Colors.black,
          style: const TextStyle(
              fontSize: 12,
              color: Color(0xffDD3155),
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 17),
              prefixIcon: Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/calender.png',
                  height: 18,
                  width: 18,
                ),
              ),
              hintText: '-  -',
              border: InputBorder.none),
        ),
      ),
    );
  }

  customTimePicker() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xffE5E5E5),
            content: StatefulBuilder(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 19,
                  ),
                  child: Container(
                    height: 250,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Pick Time',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'LabGrotesque',
                              fontSize: 12),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 200,
                          child: PageView(
                            controller: pageController,
                            children: [
                              Container(
                                height: 200,
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: customTimePMList.length,
                                    physics: const ScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8,
                                            mainAxisExtent: 35,
                                            crossAxisCount: 4),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          for (int i = 0;
                                              i < customTimePMList.length;
                                              i++) {
                                            if (i == index) {
                                              state(() {});
                                              setState(() {
                                                customTimePMList[i]
                                                    ['selected'] = true;
//to unselect another page view
                                                for (int j = 0;
                                                    j < customTimeAMList.length;
                                                    j++) {
                                                  if (customTimeAMList[j]
                                                          ['selected'] ==
                                                      true) {
                                                    customTimeAMList[j]
                                                        ['selected'] = false;
                                                  }
                                                }
                                              });
                                              pickUpController.text =
                                                  customTimePMList[i]['time'] +
                                                      ' ' +
                                                      customTimePMList[i]
                                                          ['slot'];
                                            } else {
                                              state(() {});
                                              setState(() {
                                                customTimePMList[i]
                                                    ['selected'] = false;
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 16,
                                          width: 35,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: customTimePMList[index]
                                                        ['selected'] ==
                                                    true
                                                ? const Color(0xff161821)
                                                : neumorphicColor,
                                          ),
                                          child: Text(
                                            customTimePMList[index]['time']
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: 'LabGrotesque',
                                                fontWeight: FontWeight.w500,
                                                color: customTimePMList[index]
                                                            ['selected'] ==
                                                        true
                                                    ? const Color(0xffFFFFFF)
                                                    : const Color(0xff161821)),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Container(
                                height: 200,
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: customTimeAMList.length,
                                    physics: const ScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8,
                                            mainAxisExtent: 35,
                                            crossAxisCount: 4),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          for (int i = 0;
                                              i < customTimeAMList.length;
                                              i++) {
                                            if (i == index) {
                                              state(() {});
                                              setState(() {
                                                customTimeAMList[i]
                                                    ['selected'] = true;
                                                // to unselect another page view vlaue
                                                for (int j = 0;
                                                    j < customTimePMList.length;
                                                    j++) {
                                                  if (customTimePMList[j]
                                                          ['selected'] ==
                                                      true) {
                                                    customTimePMList[j]
                                                        ['selected'] = false;
                                                  }
                                                }
                                              });
                                              pickUpController.text =
                                                  customTimeAMList[i]['time'] +
                                                      ' ' +
                                                      customTimeAMList[i]
                                                          ['slot'];
                                            } else {
                                              state(() {});
                                              setState(() {
                                                customTimeAMList[i]
                                                    ['selected'] = false;
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 16,
                                          width: 35,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: customTimeAMList[index]
                                                        ['selected'] ==
                                                    true
                                                ? const Color(0xff161821)
                                                : neumorphicColor,
                                          ),
                                          child: Text(
                                            customTimeAMList[index]['time']
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: 'LabGrotesque',
                                                fontWeight: FontWeight.w500,
                                                color: customTimeAMList[index]
                                                            ['selected'] ==
                                                        true
                                                    ? const Color(0xffFFFFFF)
                                                    : const Color(0xff161821)),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  String select = '';
  customDatePicker() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: neumorphicColor,
            content: StatefulBuilder(builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 29.65,
                        color: Color(0xffF8F7FA),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: select,
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: monthList.map((items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ));
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  select = val as String;
                                });
                              }),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: yearsList.map((items) {
                                return DropdownMenuItem(
                                    value: items, child: Text(items));
                              }).toList(),
                              onChanged: (val) {
                                // setState(() {
                                //   select = val as String;
                                // });
                              }),
                        ),
                      )
                    ],
                  )
                ],
              );
            }),
          );
        });
  }

  DateTime? date;
  getText() async {
    if (date == null) {
      return "Select Date";
    } else {
      return DateFormat('MM/dd/yyyy').format(date!);
    }
  }

  pickDate(BuildContext context) async {
    final intialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: intialDate,
        firstDate: DateTime(DateTime.now().year - 15),
        lastDate: DateTime(DateTime.now().year + 5),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData(accentColor: Colors.black), child: child!);
        });
    if (newDate != null) {
      setState(() {
        date = newDate;
      });
      if (date != null) {
        startController.text =
            DateFormat('MM/dd/yyyy').format(date!).toString();
      }
    }
  }
}
