import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/apis/api.dart';
import 'package:car_rental/modal/getcontentmodal.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/validations.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  bool isFetch = false;
  callTermsAPI(String authToken) async {
    try {
      EasyLoading.show();
      var response = await http.get(
        Uri.parse(baseUrl + getContentAPi + '62b949ad911690fd8711957a'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );

      log(response.body);
      var dataAll = json.decode(response.body);
      if (dataAll['status'] == true) {
        if (dataAll['result']['title'] != null) {
          contentList.title = dataAll['result']['title'];
        }
        if (dataAll['result']['description'] != null) {
          contentList.description = dataAll['result']['description'];
        }
        if (dataAll['result']['_id'] != null) {
          contentList.id = dataAll['result']['_id'];
        }
        setState(() {});
        isFetch = true;
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
    callTermsAPI(prefs.getString('auth_token').toString());
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  var contentList = GetContentModal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title:
            getTtile('Terms & Conditions', 16, FontWeight.w500, 'LabGrotesque'),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            isFetch == true ? createTermCond() : Container(),
            const SizedBox(
              height: 23,
            ),
            isFetch == true ? createButton() : Container(),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  Widget createButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, true);
      },
      child: Container(
          padding: const EdgeInsets.only(left: 42, right: 43),
          height: 55.58,
          child: neurphicmcontainer(
              27.5,
              Align(
                alignment: Alignment.center,
                child: getTtile('I Agree', 14, FontWeight.w500, 'LabGrotesque'),
              ))),
    );
  }

  // change with api data
  Widget createTermCond() {
    return Container(
      padding: const EdgeInsets.only(top: 14, left: 19, right: 19),
      width: MediaQuery.of(context).size.width,
      child: neurphicmcontainer(
          15,
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 11, right: 13, bottom: 13),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              getTtile(
                  contentList.title != null ? contentList.title.toString() : '',
                  14,
                  FontWeight.w500,
                  'Poppins'),
              const SizedBox(
                height: 10,
              ),
              getTtile(
                  contentList.description != null
                      ? contentList.description.toString()
                      : '',
                  12,
                  FontWeight.w400,
                  'Poppins'),
              const SizedBox(
                height: 13,
              ),
              // getTtile('Return Policy', 12, FontWeight.w500, 'LabGrotesque'),
              // const SizedBox(
              //   height: 3,
              // ),
              // getTtile(
              //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              //     12,
              //     FontWeight.w400,
              //     'LabGrotesque')
            ]),
          )),
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
