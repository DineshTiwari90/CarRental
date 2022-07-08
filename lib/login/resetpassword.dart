import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/Dashboard/dashboard.dart';
import 'package:car_rental/apis/api.dart';
import 'package:car_rental/login/signIn.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/utils/validations.dart';
import 'package:car_rental/widget/bottomimg.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;

class Resetpassword extends StatefulWidget {
  final String email;
  Resetpassword(this.email);

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String pattern = r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/';
  String text = '[a-zA-Z]';

  callresetPasswordAPI() async {
    var body = json.encode({
      'email': widget.email,
      'user_password': newPasswordController.text,
      'confirm_password': confirmPasswordController.text
    });

    try {
      EasyLoading.show();
      var response = await http.post(
        Uri.parse(baseUrl + resetPasswordApi),
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
            context, MaterialPageRoute(builder: (context) => const SignIn()));
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
                top: 195,
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
                        height: 122,
                      ),
                      resetpasswordWidget(width),
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

  Widget resetpasswordWidget(double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: neurphicmcontainer(
        25,
        Padding(
          padding:
              const EdgeInsets.only(top: 24, left: 24, right: 25, bottom: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  child: getTtile(
                      'Reset Password', 16, FontWeight.w500, 'LabGrotesque')),
              const SizedBox(
                height: 31,
              ),
              getTtile('New Password', 14, FontWeight.w500, 'LabGrotesque'),
              const SizedBox(
                height: 11,
              ),
              textfield(context, '', false, newPasswordController,
                  TextInputType.name, []),
              const SizedBox(
                height: 23,
              ),
              getTtile('Confirm Password', 14, FontWeight.w500, 'LabGrotesque'),
              const SizedBox(
                height: 11,
              ),
              Container(
                height: 55,
                child: Neumorphic(
                  margin: const EdgeInsets.only(
                      left: 8, right: 8, top: 2, bottom: 4),
                  style: NeumorphicStyle(
                      color: neumorphicColor,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(15)),
                      intensity: 1,
                      depth: NeumorphicTheme.depth(context)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                  child: TextFormField(
                    obscureText: false,
                    controller: confirmPasswordController,
                    obscuringCharacter: 'x',
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0.37),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "",
                      hintStyle: TextStyle(
                          color: Color(0xffB8B8B8),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: 0.37),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 38,
              ),
              InkWell(
                onTap: () {
                  RegExp emailregExp = RegExp(emailPattern.trim());
                  RegExp passwordregExp = RegExp(emailPattern.trim());

                  if (newPasswordController.text.isEmpty) {
                    EasyLoading.showToast('Enter new password');
                  } else if (confirmPasswordController.text.isEmpty) {
                    EasyLoading.showToast('Enter confirm password');
                  } else if (newPasswordController.text !=
                      confirmPasswordController.text) {
                    EasyLoading.showToast('Password not match');
                  } else if (newPasswordController.text.length < 6) {
                    EasyLoading.showToast(
                        'Password should be minimum in 6 character.');
                  } else if (!passwordregExp
                      .hasMatch(newPasswordController.text)) {
                    EasyLoading.showToast(
                        'Password should be one letter Capital, one digit and one special character');
                  } else {
                    print(widget.email);
                    callresetPasswordAPI();
                  }
                },
                child: Container(
                  height: 55,
                  width: width,
                  child: neurphicmcontainer(
                    27,
                    Align(
                        alignment: Alignment.center,
                        child: getTtile('Set Password', 14, FontWeight.w500,
                            'LabGrotesque')),
                  ),
                ),
              ),
            ],
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
