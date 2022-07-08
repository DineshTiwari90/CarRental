import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/apis/api.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  callchangePasswordAPI() async {
    var body = json.encode({
      'old_password': oldPasswordController.text,
      'new_password': newPasswordController.text,
      'confirm_password': confirmPasswordController.text
    });

    try {
      EasyLoading.show();
      var response = await http.put(
        Uri.parse(baseUrl + changePasswordApi),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      log(response.body);
      var dataAll = json.decode(response.body);
      if (dataAll['status'] == true) {
        showInSnackBar(Colors.green, dataAll['message'], context);
        Navigator.pop(context);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const SignIn()));
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
    authToken = prefs.getString('auth_token').toString();
    print(prefs.getString('auth_token'));
    print(prefs.getBool('login'));
  }

  String authToken = '';

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Change Password', 16, FontWeight.w500, 'LabGrotesque'),
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
        padding: const EdgeInsets.only(top: 14, left: 19, right: 19),
        child: Container(
          height: 500,
          child: Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                lightSource: LightSource.topLeft,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                intensity: 1,
                color: neumorphicColor),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 24,
                right: 23,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTtile(
                        'Old Password', 14, FontWeight.w500, 'LabGrotesque'),
                    const SizedBox(
                      height: 11,
                    ),
                    textfield(context, '', false, oldPasswordController,
                        TextInputType.name, []),
                    const SizedBox(
                      height: 23,
                    ),
                    getTtile(
                        'New Password', 14, FontWeight.w500, 'LabGrotesque'),
                    const SizedBox(
                      height: 11,
                    ),
                    textfield(context, '', false, newPasswordController,
                        TextInputType.name, []),
                    const SizedBox(
                      height: 23,
                    ),
                    getTtile('Confirm Password', 14, FontWeight.w500,
                        'LabGrotesque'),
                    const SizedBox(
                      height: 11,
                    ),
                    textfield(context, '', false, confirmPasswordController,
                        TextInputType.name, []),
                    const SizedBox(
                      height: 51,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (oldPasswordController.text.isEmpty) {
                          EasyLoading.showToast('Enter Old Password');
                        } else if (newPasswordController.text.isEmpty) {
                          EasyLoading.showToast('Enter Old Password');
                        } else if (newPasswordController.text.length < 6) {
                          EasyLoading.showToast('Password Length Should Be 6');
                        } else if (confirmPasswordController.text.isEmpty) {
                          EasyLoading.showToast('Enter Old Password');
                        } else if (newPasswordController.text !=
                            confirmPasswordController.text) {
                          EasyLoading.showToast(
                              "New Password And Confirm Password Should be Same");
                        } else {
                          callchangePasswordAPI();
                        }
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              color: neumorphicColor,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(27.5)),
                              intensity: 12,
                              depth: NeumorphicTheme.depth(context)),
                          child: Align(
                              alignment: Alignment.center,
                              child: getTtile('Set Password', 14,
                                  FontWeight.w500, 'LabGrotesque')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
