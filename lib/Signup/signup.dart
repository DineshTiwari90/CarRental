import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/Signup/moredetails.dart';
import 'package:car_rental/Signup/signupotp.dart';
import 'package:car_rental/login/signIn.dart';
import 'package:car_rental/utils/capitallettes.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/utils/validations.dart';
import 'package:car_rental/widget/bottomimg.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;

import '../apis/api.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  callSignupApi() async {
    var body = json.encode({
      'name': firstNameController.text,
      'sur_name': lastNameController.text,
      'email': emailController.text,
      'phone_number': phoneController.text,
      'user_password': passwordController.text,
      'confirm_password': confirmPasswordController.text
    });

    try {
      EasyLoading.show();
      var response = await http.post(
        Uri.parse(baseUrl + signUpApi),
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
                builder: (context) => SignupOTP(dataAll['result']['user_id'])));

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
      body: Container(
        color: backgroundcolor,
        child: Stack(
          children: [
            bottamImg(),
            Padding(
              padding: const EdgeInsets.only(
                top: 51,
              ),
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
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
                        height: 32,
                      ),
                      getTtile('WELCOME', 22, FontWeight.w500, 'LabGrotesque'),
                      const SizedBox(
                        height: 6,
                      ),
                      getTtile('Continue With Your Details', 14,
                          FontWeight.w500, 'LabGrotesque'),
                      const SizedBox(
                        height: 56,
                      ),
                      createAccount(width),
                      const SizedBox(
                        height: 19,
                      ),
                      loginTypes(width),
                      const SizedBox(
                        height: 41,
                      ),
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

  Widget loginTypes(double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            lightSource: LightSource.topLeft,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25)),
            intensity: 1,
            shadowLightColor: const Color(0xffFAF9F9),
            color: neumorphicColor),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 21, left: 23, right: 19.55, bottom: 19),
          child: Column(
            children: [
              getTtile("Log In With", 14, FontWeight.w500, 'LabGrotesque'),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 55,
                    width: 135.5,
                    child: Neumorphic(
                        style: NeumorphicStyle(
                            color: neumorphicColor,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(27.5)),
                            intensity: 1,
                            depth: NeumorphicTheme.depth(context)),
                        child: Image.asset('assets/images/Google.png')),
                  ),
                  const SizedBox(
                    width: 19.5,
                  ),
                  Flexible(
                    child: Container(
                      height: 55,
                      width: 135.5,
                      child: Neumorphic(
                          style: NeumorphicStyle(
                              color: neumorphicColor,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(27.5)),
                              intensity: 1,
                              depth: NeumorphicTheme.depth(context)),
                          child: Image.asset('assets/images/instra.png')),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createAccount(double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: neurphicmcontainer(
        25,
        Padding(
          padding:
              const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  child: getTtile(
                      'Create Account', 16, FontWeight.w500, 'LabGrotesque')),
              const SizedBox(
                height: 31,
              ),
              Container(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTtile('Name', 12, FontWeight.w500, 'LabGrotesque'),
                        const SizedBox(
                          height: 13,
                        ),
                        Container(
                            width: width / 2.5,
                            child: textfield(context, '', false,
                                firstNameController, TextInputType.name, [])),
                      ],
                    ),
                    const SizedBox(
                      width: 16.65,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTtile(
                              'Surname', 12, FontWeight.w500, 'LabGrotesque'),
                          const SizedBox(
                            height: 13,
                          ),
                          Container(
                              width: width / 2,
                              child: textfield(context, '', false,
                                  lastNameController, TextInputType.name, [])),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              getTtile('Email', 14, FontWeight.w500, 'LabGrotesque'),
              const SizedBox(
                height: 3,
              ),
              textfield(context, '', false, emailController,
                  TextInputType.emailAddress, []),
              const SizedBox(
                height: 23,
              ),
              getTtile('Phone Number', 14, FontWeight.w500, 'LabGrotesque'),
              const SizedBox(
                height: 3,
              ),
              textfield(
                  context, '', false, phoneController, TextInputType.phone, [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10)
              ]),
              const SizedBox(
                height: 23,
              ),
              getTtile('Password', 14, FontWeight.w500, 'LabGrotesque'),
              const SizedBox(
                height: 3,
              ),
              textfield(
                context,
                '',
                false,
                passwordController,
                TextInputType.name,
                [],
              ),
              const SizedBox(
                height: 23,
              ),
              getTtile('Confirm Password', 14, FontWeight.w500, 'LabGrotesque'),
              const SizedBox(
                height: 3,
              ),
              textfield(context, '', false, confirmPasswordController,
                  TextInputType.name, []),
              const SizedBox(
                height: 38,
              ),
              GestureDetector(
                onTap: () {
                  RegExp emailregExp = RegExp(emailPattern.trim());
                  RegExp passwordregExp = RegExp(passwordPattern.trim());

                  if (firstNameController.text.isEmpty) {
                    EasyLoading.showToast('Enter Your Name');
                  } else if (lastNameController.text.isEmpty) {
                    EasyLoading.showToast('Enter Your Surname');
                  } else if (emailController.text.isEmpty) {
                    EasyLoading.showToast('Enter Your Email id');
                  } else if (!emailregExp.hasMatch(emailController.text)) {
                    EasyLoading.showToast('Please Enter Valid Email Id');
                  } else if (phoneController.text.isEmpty) {
                    EasyLoading.showToast('Enter Your Number');
                  } else if (phoneController.text.length < 10) {
                    EasyLoading.showToast('Phone Number Should Be 10 Digit');
                  } else if (passwordController.text.isEmpty) {
                    EasyLoading.showToast('Enter Your Password');
                  } else if (passwordController.text.length < 6) {
                    EasyLoading.showToast(
                        'Password should be minimum in 6 character.');
                  } else if (!passwordregExp
                      .hasMatch(passwordController.text)) {
                    EasyLoading.showToast(
                        'Password should be one letter Capital, one digit and one special character');
                  } else if (confirmPasswordController.text.isEmpty) {
                    EasyLoading.showToast('Enter Your Confirm Password');
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    EasyLoading.showToast('Password Not Match');
                  } else {
                    callSignupApi();
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
                        child: getTtile(
                            'Sign Up', 14, FontWeight.w500, 'LabGrotesque')),
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              Align(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Already Have An Account?',
                      style: const TextStyle(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              },
                            text: 'Sign In',
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.w500))
                      ])
                ])),
              )
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
          // shadowLightColor: const Color(0xffFAF9F9),
          color: neumorphicColor),
      child: child,
    );
  }

  Neumorphic embossNeurphicm(Widget child) {
    return Neumorphic(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            intensity: 1,
            depth: NeumorphicTheme.embossDepth(context)),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
        child: child);
  }

  void showInSnackBar(Color color, String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(backgroundColor: color, content: Text(value)));
  }
}
