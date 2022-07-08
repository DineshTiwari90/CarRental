import 'dart:convert';
import 'dart:developer';
import 'package:car_rental/apis/api.dart';
import 'package:car_rental/login/otherecoverymethod.dart';
import 'package:car_rental/login/otpscreen.dart';
import 'package:car_rental/support/supporteam.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/bottomimg.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  String patttern =
      r'^(([^<>()[\]\\.,;:@\"]+(\.[^<>()[\]\\.,;:@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  callForgotPasswordByEmailAPI() async {
    var body = json.encode({'email': emailController.text});

    try {
      EasyLoading.show();
      var response = await http.post(
        Uri.parse(baseUrl + forgotPasswordByemail),
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
                    'forgotemail', emailController.text)));

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
                  top: 165,
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
                          height: 131,
                        ),
                        forgotWidget(width),
                        const SizedBox(
                          height: 23,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget forgotWidget(double width) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Container(
        width: width,
        child: neurphicmcontainer(
          25,
          Padding(
            padding:
                const EdgeInsets.only(top: 31, left: 24, right: 25, bottom: 54),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: getTtile(
                      'Forgot Password', 16, FontWeight.w500, 'LabGrotesque'),
                ),
                const SizedBox(
                  height: 31,
                ),
                getTtile('Email', 14, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 11,
                ),
                textfield(context, '', false, emailController,
                    TextInputType.emailAddress, []),
                const SizedBox(
                  height: 37,
                ),
                GestureDetector(
                  onTap: () {
                    RegExp regExp = RegExp(patttern.trim());

                    if (emailController.text.isEmpty) {
                      EasyLoading.showToast('Enter Your Email Id');
                    } else if (!regExp.hasMatch(emailController.text)) {
                      EasyLoading.showToast('Please Enter Valid Email Id');
                    } else {
                      callForgotPasswordByEmailAPI();
                    }
                  },
                  child: Container(
                    height: 55,
                    width: width,
                    child: neurphicmcontainer(
                      27,
                      Align(
                          alignment: Alignment.center,
                          child: getTtile(
                              'Submit', 14, FontWeight.w500, 'LabGrotesque')),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OtherecoveryMethod()));
                        },
                        child: getTtile('Other Recovery Methods', 14,
                            FontWeight.w500, 'LabGrotesque'))),
                const SizedBox(
                  height: 18,
                ),
                Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SupportTeam()));
                        },
                        child: getTtile('Reach Out To Support', 14,
                            FontWeight.w500, 'LabGrotesque'))),
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
