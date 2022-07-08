import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Cripto extends StatefulWidget {
  const Cripto({Key? key}) : super(key: key);

  @override
  State<Cripto> createState() => _CriptoState();
}

class _CriptoState extends State<Cripto> {
  List cryptoList = [
    {
      'title':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      'isSelect': false
    },
    {
      'title':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      'isSelect': false
    },
    {
      'title':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      'isSelect': false
    },
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Crypto', 16, FontWeight.w500, 'LabGrotesque'),
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
        padding: const EdgeInsets.only(top: 17, left: 19, right: 19),
        child: ListView(
          shrinkWrap: true,
          children: [
            buildCryptoList(),
            const SizedBox(
              height: 67,
            ),
            buildButton()
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    return Container(
        padding: const EdgeInsets.only(left: 24, right: 23),
        height: 51.14,
        child: neurphicmcontainer(
            27.5,
            Align(
              alignment: Alignment.center,
              child:
                  getTtile('Make Payment', 14, FontWeight.w500, 'LabGrotesque'),
            )));
  }

  Widget buildCryptoList() {
    return Container(
      child: ListView.separated(
          separatorBuilder: (context, _) {
            return const SizedBox(
              height: 18,
            );
          },
          itemCount: cryptoList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 67,
              child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        for (int i = 0; i < cryptoList.length; i++) {
                          if (i == index) {
                            setState(() {
                              cryptoList[i]['isSelect'] = true;
                            });
                          } else {
                            setState(() {
                              cryptoList[i]['isSelect'] = false;
                            });
                          }
                        }
                      });
                    },
                    child: neurphicmcontainer(
                        12,
                        ListTile(
                          leading: cryptoList[index]['isSelect'] == false
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
                          title: getTtile(cryptoList[index]['title'], 12,
                              FontWeight.w400, 'LabGrotesque'),
                        )),
                  )),
            );
          }),
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
