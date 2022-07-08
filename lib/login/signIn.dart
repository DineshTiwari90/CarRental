import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/Dashboard/dashboard.dart';
import 'package:car_rental/Signup/signup.dart';
import 'package:car_rental/apis/api.dart';
import 'package:car_rental/login/forgetpassword.dart';
import 'package:car_rental/login/otpscreen.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/utils/sharepreference.dart';
import 'package:car_rental/utils/validations.dart';
import 'package:car_rental/widget/bottomimg.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String pattern = r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/';
  String text = '[a-zA-Z]';

  callSignupApi() async {
    var body = json.encode({
      'user_name': emailPhoneController.text,
      'user_password': passwordController.text
    });

    try {
      EasyLoading.show();
      var response = await http.post(
        Uri.parse(baseUrl + loginapi),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      log(response.body);
      var dataAll = json.decode(response.body);
      if (dataAll['status'] == true) {
        if (dataAll['result']['otp_verified'] == true) {
          showInSnackBar(Colors.green, dataAll['message'], context);
          log(json.encode(dataAll['result']['token']));
          setToken(dataAll['result']['token']);
          setUserId(dataAll['result']['id']);
          setLogin(true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Dashboard()));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPScreen(dataAll['result']['id'],
                      'login', emailPhoneController.text)));
          showInSnackBar(Colors.red, dataAll['message'], context);
        }

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        color: backgroundcolor,
        child: Stack(
          children: [
            bottamImg(),
            Padding(
              padding: const EdgeInsets.only(
                top: 51,
              ),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 52.48,
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
                      height: 32,
                    ),
                    const Text(
                      'WELCOME',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: black,
                        letterSpacing: 0.7,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      "Let's Start",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 56,
                    ),
                    logInwidget(width),
                    const SizedBox(
                      height: 18,
                    ),
                    typesofLogin(width),
                    const SizedBox(
                      height: 33,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget logInwidget(double width) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      child: neurphicmcontainer(
        25,
        Padding(
          padding:
              const EdgeInsets.only(top: 24, left: 24, right: 25, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  child:
                      getTtile('Log In', 16, FontWeight.w500, 'LabGrotesque')),
              const SizedBox(
                height: 31,
              ),
              getTtile(
                  'Email/Phone Number', 14, FontWeight.w500, 'LabGrotesque'),
              const SizedBox(
                height: 11,
              ),
              textfield(context, '', false, emailPhoneController,
                  TextInputType.emailAddress, []),
              const SizedBox(
                height: 23,
              ),
              getTtile('Password', 14, FontWeight.w500, 'LabGrotesque'),
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
                  padding: const EdgeInsets.only(left: 19, top: 2),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    obscuringCharacter: 'x',
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0.37),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "",
                        hintStyle: const TextStyle(
                            color: Color(0xffB8B8B8),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            letterSpacing: 0.37),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8, right: 7, top: 6),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPassword()));
                            },
                            child: Container(
                              width: 41,
                              // height: 41,
                              child: Neumorphic(
                                  style: NeumorphicStyle(
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(7)),
                                      color: const Color(0xffDDDCDC)),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '?',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xffDD3155)),
                                    ),
                                  )),
                            ),
                          ),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  RegExp regExp = RegExp(pattern);
                  RegExp emailExp = RegExp(emailPattern);

                  if (emailPhoneController.text.isEmpty) {
                    EasyLoading.showToast('Enter Your Number Or Email');
                  } else if (passwordController.text.isEmpty) {
                    EasyLoading.showToast('Enter Your Password');
                  }
                  // else if (!regExp.hasMatch(emailPhoneController.text) &&
                  //     !emailExp.hasMatch(emailPhoneController.text)) {
                  //   // ignore: unrelated_type_equality_checks
                  //   emailPhoneController.text == text
                  //       ? EasyLoading.showToast('Please enter valid email id')
                  //       : EasyLoading.showToast('Please enter valid number');
                  // }
                  else {
                    callSignupApi();
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
                            'Log In', 14, FontWeight.w500, 'LabGrotesque')),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.center,
                child: Text.rich(TextSpan(
                    text: "Don't Have An Account?",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: black),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                          text: 'Sign Up',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffDD3155)))
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget typesofLogin(double width) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      child: Container(
        width: width,
        height: 144,
        child: neurphicmcontainer(
            25,
            Padding(
              padding: const EdgeInsets.only(top: 21, bottom: 19),
              child: Column(
                children: [
                  const Text(
                    "Log In With",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: black),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 55,
                        width: 135.5,
                        child: neurphicmcontainer(
                            27.5, Image.asset('assets/images/Google.png')),
                      ),
                      Container(
                        height: 55,
                        width: 135.5,
                        child: neurphicmcontainer(
                            27.5, Image.asset('assets/images/instra.png')),
                      )
                    ],
                  )
                ],
              ),
            )),
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
          // shadowLightColor: const Color(0xffFAF9F9),
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
