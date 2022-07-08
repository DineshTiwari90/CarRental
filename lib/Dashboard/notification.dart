import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: neumorphicColor,
        title: getTtile('Notifications', 16, FontWeight.w500, 'LabGrotesque'),
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
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 17, left: 18, right: 18),
            child: getTtile('Today', 14, FontWeight.w500, 'LabGrotesque'),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 10,
              padding: const EdgeInsets.only(top: 19, left: 18, right: 18),
              itemBuilder: (context, index) {
                return index == 3
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTtile(
                              'This Week', 14, FontWeight.w500, 'LabGrotesque'),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      )
                    : Column(
                        children: [
                          notificationwidget(index),
                          const SizedBox(
                            height: 19,
                          )
                        ],
                      );
              })
        ],
      ),
    );
  }

  Widget notificationwidget(int index) {
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        Expanded(
          child: Container(
            height: 200,
            color: Colors.black,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/delete.png',
              height: 32,
              width: 32,
            ),
          ),
        )
        // SlidableAction(
        //     backgroundColor: black, icon: Icons.delete, onPressed: (context) {})
      ]),
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            lightSource: LightSource.topLeft,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            intensity: 1,
            depth: 0,
            // shadowLightColor: const Color(0xffFAF9F9),
            color: neumorphicColor),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 11),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/notificationicon.png'))),
              ),
              const SizedBox(
                width: 12,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTtile('loream ipsum is simply', 14, FontWeight.w400,
                          'LabGrotesque'),
                      const SizedBox(
                        height: 9,
                      ),
                      getTtile(
                          'Lorem Ipsum is simply dummy text of the printing and',
                          12,
                          FontWeight.w400,
                          'LabGrotesque'),
                      const SizedBox(
                        height: 4,
                      ),
                      getTtile(
                          '09:AM | 13 JUn', 10, FontWeight.w400, 'LabGrotesque')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
