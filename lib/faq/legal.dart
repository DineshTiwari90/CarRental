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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Legal extends StatefulWidget {
  const Legal({Key? key}) : super(key: key);

  @override
  State<Legal> createState() => _LegalState();
}

class _LegalState extends State<Legal> {
  bool isLoading = false;
  bool isFetch = false;
  callLegalAPI(String authToken) async {
    try {
      EasyLoading.show();
      var response = await http.get(
        Uri.parse(baseUrl + getContentAPi + '62b949ca911690fd8711957d'),
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
        EasyLoading.dismiss();
        isFetch = true;
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
    callLegalAPI(prefs.getString('auth_token').toString());
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
        title: getTtile('Legal', 16, FontWeight.w500, 'LabGrotesque'),
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
        children: [
          isFetch == true
              ? legalInfo(
                  contentList.title != null ? contentList.title.toString() : '',
                  contentList.description != null
                      ? contentList.description.toString()
                      : '')
              : Container(),
          const SizedBox(
            height: 19,
          )
        ],
      )),
    );
  }

  Widget legalInfo(String title, String text) {
    return Container(
      padding: EdgeInsets.only(top: 14, left: 12, right: 12),
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
              getTtile(title, 12, FontWeight.w600, 'Poppins'),
              const SizedBox(
                height: 15,
              ),
              getTtile(text, 12, FontWeight.w400, 'Poppins')
            ],
          ),
        ),
      ),
    );
  }
}
