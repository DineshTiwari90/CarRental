import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/apis/api.dart';
import 'package:car_rental/modal/getcontentmodal.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/utils/validations.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  bool isFetch = false;
  callaboutUsAPI(String authToken) async {
    try {
      EasyLoading.show();
      var response = await http.get(
        Uri.parse(baseUrl + getContentAPi + '62b94936911690fd87119577'),
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
    callaboutUsAPI(prefs.getString('auth_token').toString());
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
        title: getTtile('About Us', 16, FontWeight.w500, 'LabGrotesque'),
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
        physics: const ScrollPhysics(),
        children: [
          logoheading(),
          const SizedBox(
            height: 29,
          ),
          isFetch == true ? aboutusWidget1() : Container(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget logoheading() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 14, left: 19, right: 19),
      width: double.infinity,
      child: Neumorphic(
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            intensity: 1,
            depth: NeumorphicTheme.depth(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 52.46,
              width: 180,
            ),
            const SizedBox(
              height: 15.54,
            ),
            getTtile('KEEPER OF THE KEYS', 14, FontWeight.w400, 'LabGrotesque')
          ],
        ),
      ),
    );
  }

  Widget aboutusWidget1() {
    return Container(
      padding: const EdgeInsets.only(left: 19, right: 19),
      width: double.infinity,
      child: Neumorphic(
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            intensity: 1,
            depth: NeumorphicTheme.depth(context)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 12, right: 12, bottom: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getTtile(
                  contentList.title != null ? contentList.title.toString() : '',
                  12,
                  FontWeight.w600,
                  'Poppins'),
              const SizedBox(
                height: 25,
              ),
              getTtile(
                  contentList.description != null
                      ? contentList.description.toString()
                      : '',
                  12,
                  FontWeight.w400,
                  'Poppins'),
            ],
          ),
        ),
      ),
    );
  }
}
