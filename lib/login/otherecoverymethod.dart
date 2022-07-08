import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/apis/api.dart';
import 'package:car_rental/login/otpscreen.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../widget/bottomimg.dart';

class OtherecoveryMethod extends StatefulWidget {
  const OtherecoveryMethod({Key? key}) : super(key: key);

  @override
  State<OtherecoveryMethod> createState() => _OtherecoveryMethodState();
}

class _OtherecoveryMethodState extends State<OtherecoveryMethod> {
  final TextEditingController phoneController = TextEditingController();

  callForgotPasswordByNumberAPI() async {
    var body = json.encode({'phone_number': phoneController.text});

    try {
      EasyLoading.show();
      var response = await http.post(
        Uri.parse(baseUrl + forgotPasswordByphone),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      log(response.body);
      var dataAll = json.decode(response.body);
      if (dataAll['status'] == true) {
        showInSnackBar(Colors.green, dataAll['message'], context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OTPScreen(dataAll['result']['user_id'],
                    'forgotphone', dataAll['result']['email'])));
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        width: width,
        color: backgroundcolor,
        child: Stack(
          children: [
            bottamImg(),
            Padding(
              padding: const EdgeInsets.only(
                top: 187,
                left: 18,
                right: 18,
              ),
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
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
                      const Text(
                        'KEEPER OF THE KEYS',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: black),
                      ),
                      const SizedBox(
                        height: 138,
                      ),
                      otheRecoveryWidget(width),
                      const SizedBox(
                        height: 23,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget otheRecoveryWidget(double width) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Container(
        width: width,
        child: neurphicmcontainer(
          25,
          Padding(
            padding:
                const EdgeInsets.only(top: 26, left: 24, right: 25, bottom: 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: getTtile('Other Recovery Methods', 16, FontWeight.w500,
                      'LabGrotesque'),
                ),
                const SizedBox(
                  height: 14,
                ),
                Align(
                    alignment: Alignment.center,
                    child: getTtile('Password Recovery', 16, FontWeight.w500,
                        'LabGrotesque')),
                const SizedBox(
                  height: 50,
                ),
                getTtile(
                    'Use Phone Number', 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 11,
                ),
                textfield(
                    context, '', false, phoneController, TextInputType.number, [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10)
                ]),
                const SizedBox(
                  height: 27,
                ),
                const Text(
                  "Didn’t Remember Number",
                  style: TextStyle(
                      color: Color(0xffDD3155),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 41,
                ),
                GestureDetector(
                  onTap: () {
                    if (phoneController.text.isEmpty) {
                      EasyLoading.showToast('Enter Your Number');
                    } else if (phoneController.text.length < 10) {
                      EasyLoading.showToast('Please Enter Valid Number');
                    } else {
                      callForgotPasswordByNumberAPI();
                    }
                  },
                  child: Container(
                    height: 55,
                    width: width,
                    child: neurphicmcontainer(
                      27.5,
                      Align(
                          alignment: Alignment.center,
                          child: getTtile(
                              'Send OTP', 14, FontWeight.w500, 'LabGrotesque')),
                    ),
                  ),
                ),
              ],
            ),
          ),
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

  void showInSnackBar(Color color, String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(backgroundColor: color, content: Text(value)));
  }
}
