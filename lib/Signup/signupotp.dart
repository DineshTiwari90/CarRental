import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/Signup/moredetails.dart';
import 'package:car_rental/apis/api.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/bottomimg.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;

class SignupOTP extends StatefulWidget {
  final String userid;
  SignupOTP(this.userid);
  @override
  State<SignupOTP> createState() => _SignupOTPState();
}

class _SignupOTPState extends State<SignupOTP> {
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();

  final FocusScopeNode node1 = FocusScopeNode();
  final FocusScopeNode node2 = FocusScopeNode();
  final FocusScopeNode node3 = FocusScopeNode();
  final FocusScopeNode node4 = FocusScopeNode();

  callverifyOTPAPI() async {
    var body = json.encode({
      'user_id': widget.userid,
      'otp': otp1.text + otp2.text + otp3.text + otp4.text
    });
    try {
      EasyLoading.show();
      var response = await http.post(
        Uri.parse(baseUrl + verifyOTP),
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
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MoreDetails()));
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
                top: 120,
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
                        height: 209,
                      ),
                      verificationcodeWidget(width),
                      const SizedBox(
                        height: 23,
                      )
                      // otheRecoveryWidget(width)
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

  Widget verificationcodeWidget(double width) {
    return Container(
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            lightSource: LightSource.topLeft,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25)),
            intensity: 1,
            shadowLightColor: const Color(0xffFAF9F9),
            color: neumorphicColor),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 24, left: 24, right: 25, bottom: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: getTtile(
                    'Verification Code', 16, FontWeight.w500, 'LabGrotesque'),
              ),
              const SizedBox(
                height: 31,
              ),
              getTtile('Enter OTP', 14, FontWeight.w500, 'LabGrotesque'),
              const SizedBox(
                height: 11,
              ),
              Row(
                children: [
                  customOTP(otp1, true, node1, (val) {
                    if (val.isNotEmpty) {
                      node2.nextFocus();
                    }
                  }),
                  customOTP(otp2, false, node2, (val) {
                    if (val.isNotEmpty) {
                      node3.nextFocus();
                    } else {
                      node1.previousFocus();
                    }
                  }),
                  customOTP(otp3, false, node3, (val) {
                    if (val.isNotEmpty) {
                      node4.nextFocus();
                    } else {
                      node2.previousFocus();
                    }
                  }),
                  customOTP(otp4, false, node4, (val) {
                    if (val.isEmpty) {
                      node3.previousFocus();
                    }
                  }),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              GestureDetector(
                onTap: () {
                  if (otp1.text.isEmpty ||
                      otp2.text.isEmpty ||
                      otp3.text.isEmpty ||
                      otp4.text.isEmpty) {
                    EasyLoading.showToast('Enter OTP');
                  } else {
                    // print(otp1.text + otp2.text + otp3.text + otp4.text);
                    callverifyOTPAPI();
                  }
                },
                child: Container(
                  height: 55,
                  width: width,
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        color: neumorphicColor,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(27.5)),
                        intensity: 12,
                        depth: NeumorphicTheme.depth(context)),
                    child: Align(
                        alignment: Alignment.center,
                        child: getTtile(
                            'Verify', 14, FontWeight.w500, 'LabGrotesque')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  customOTP(
    TextEditingController controller,
    bool autofocus,
    FocusScopeNode focusScopeNode,
    ValueChanged<String>? onChanged,
  ) {
    return Expanded(
      child: Container(
        width: 70,
        child: FocusScope(
          // autofocus: true,
          node: focusScopeNode,
          child: Neumorphic(
            margin: const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 4),
            style: NeumorphicStyle(
                color: neumorphicColor,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                intensity: 1,
                depth: NeumorphicTheme.embossDepth(context)),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1)
              ],
              onChanged: onChanged,
              autofocus: autofocus,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
        ),
      ),
    );
  }

  void showInSnackBar(Color color, String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(backgroundColor: color, content: Text(value)));
  }
}
