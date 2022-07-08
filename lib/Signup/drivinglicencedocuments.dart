import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/Signup/passport.dart';
import 'package:car_rental/modal/profileModal.dart';
import 'package:car_rental/utils/capitallettes.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/utils/validations.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../apis/api.dart';

class DrivingLicenseDocuments extends StatefulWidget {
  const DrivingLicenseDocuments({Key? key}) : super(key: key);

  @override
  State<DrivingLicenseDocuments> createState() =>
      _DrivingLicenseDocumentsState();
}

class _DrivingLicenseDocumentsState extends State<DrivingLicenseDocuments> {
  callgetDrivingAPI(String authToken) async {
    try {
      EasyLoading.show();
      var response = await http.get(
        Uri.parse(baseUrl + getProfileAPi),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );

      log(response.body);
      var dataAll = json.decode(response.body);
      if (dataAll['status'] == true) {
        userProfileList.licenseName = dataAll['result']['license_name'];
        userProfileList.licenseSurName = dataAll['result']['license_sur_name'];
        userProfileList.licenseNo = dataAll['result']['license_no'];
        userProfileList.expiryDate = dataAll['result']['expiry_date'];
        userProfileList.licenseCountry = dataAll['result']['license_country'];
        userProfileList.licenseCategory = dataAll['result']['license_category'];

        if (dataAll['result']['license_photo'] != null &&
            dataAll['result']['license_photo'] != '') {
          userProfileList.licensePhoto = dataAll['result']['license_photo'];
          for (int i = 0; i < userProfileList.licensePhoto!.length; i++) {
            licenseImg = userProfileList.licensePhoto![i];
          }
        }

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

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid').toString();
    authToken = prefs.getString('auth_token').toString();
    callgetDrivingAPI(prefs.getString('auth_token').toString());
  }

  var userProfileList = ProfileModal();

  @override
  void initState() {
    getToken();
    super.initState();
  }

  String userId = '';
  String authToken = '';

  String licenseImg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Documents', 16, FontWeight.w500, 'LabGrotesque'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          drivingLicenceDocuments(),
          const SizedBox(
            height: 18,
          ),
          passportWidget()
        ],
      ),
    );
  }

  Widget passportWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Passport('drivingdoc')));
      },
      child: Container(
        height: 51.14,
        padding: const EdgeInsets.only(left: 18, right: 18),
        width: double.infinity,
        child: Neumorphic(
          style: NeumorphicStyle(
              color: neumorphicColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
              intensity: 1,
              depth: NeumorphicTheme.depth(context)),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getTtile('Passport', 14, FontWeight.w500, 'LabGrotesque'),
                Container(
                  child: Image.asset(
                    'assets/images/backfill.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget drivingLicenceDocuments() {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 18, right: 18),
      child: Neumorphic(
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            intensity: 1,
            depth: NeumorphicTheme.depth(context)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 17, left: 13, right: 10, bottom: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTtile(
                      'Driving License', 14, FontWeight.w500, 'LabGrotesque'),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/arrow_down.png',
                      width: 24,
                      height: 24,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              documentField(
                  'Name',
                  userProfileList.licenseName != null
                      ? userProfileList.licenseName.toString().capitalize()
                      : ''),
              const SizedBox(
                height: 23,
              ),
              documentField(
                  'Surname',
                  userProfileList.licenseSurName != null
                      ? userProfileList.licenseSurName.toString().capitalize()
                      : ''),
              const SizedBox(
                height: 23,
              ),
              documentField(
                  'Driving License Number', userProfileList.licenseNo ?? ''),
              const SizedBox(
                height: 23,
              ),
              documentField('Expiry Date', userProfileList.expiryDate ?? ''),
              const SizedBox(
                height: 23,
              ),
              documentField(
                  'Country Of Issue', userProfileList.licenseCountry ?? '-'),
              const SizedBox(
                height: 23,
              ),
              documentField("Category", userProfileList.licenseCategory ?? ''),
              const SizedBox(
                height: 36,
              ),
              Container(
                height: 176,
                width: 312,
                child: Neumorphic(
                  style: NeumorphicStyle(
                      color: neumorphicColor,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(15)),
                      intensity: 1,
                      depth: NeumorphicTheme.depth(context)),
                  child: licenseImg.isNotEmpty && licenseImg != ''
                      ? Image.network(
                          licenseImg,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Image.asset('assets/images/card.png'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget documentField(String title, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getTtile(title, 12, FontWeight.w500, 'LabGrotesque'),
        getTtile(text, 12, FontWeight.w500, 'LabGrotesque')
      ],
    );
  }
}
