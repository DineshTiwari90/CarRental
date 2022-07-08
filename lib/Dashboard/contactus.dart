import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/apis/api.dart';
import 'package:car_rental/utils/validations.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;

class ContactUs extends StatefulWidget {
  ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  callContactUsApi() async {
    var body = json.encode({
      'name': firstNameController.text,
      'sur_name': lastNameController.text,
      'phone_number': phoneController.text,
      'email': emailController.text,
      'message': messageController.text
    });

    try {
      EasyLoading.show();
      var response = await http.post(
        Uri.parse(baseUrl + contactupApi),
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
        Navigator.pop(context);
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
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Contact Us', 16, FontWeight.w500, 'LabGrotesque'),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 24,
            width: 24,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/arrow_back.png'))),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
            child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    lightSource: LightSource.topLeft,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                    intensity: 1,
                    color: neumorphicColor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 13, top: 18, right: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 339,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getTtile('Name', 12, FontWeight.w500,
                                    'LabGrotesque'),
                                const SizedBox(
                                  height: 13,
                                ),
                                Container(
                                  height: 55,
                                  width: 145.35,
                                  child: textfield(context, '', false,
                                      firstNameController, TextInputType.name, [
                                    FilteringTextInputFormatter(
                                        RegExp(r'[a-zA-Z]'),
                                        allow: true)
                                  ]),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 16.65,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getTtile('Surname', 12, FontWeight.w500,
                                      'LabGrotesque'),
                                  const SizedBox(
                                    height: 13,
                                  ),
                                  Container(
                                    width: 165,
                                    height: 55,
                                    child: textfield(
                                        context,
                                        '',
                                        false,
                                        lastNameController,
                                        TextInputType.name, [
                                      FilteringTextInputFormatter(
                                          RegExp(r'[a-zA-Z]'),
                                          allow: true)
                                    ]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      getTtile('Email', 12, FontWeight.w500, 'LabGrotesque'),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        height: 55,
                        width: 333,
                        child: textfield(context, '', false, emailController,
                            TextInputType.emailAddress, []),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      getTtile(
                          'Phone Number', 12, FontWeight.w500, 'LabGrotesque'),
                      const SizedBox(height: 3),
                      Container(
                        height: 55,
                        width: 333,
                        child: textfield(context, '', false, phoneController,
                            TextInputType.number, [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10)
                        ]),
                      ),
                      const SizedBox(height: 9),
                      getTtile('Message', 12, FontWeight.w500, 'Lag Grotesque'),
                      const SizedBox(
                        height: 3,
                      ),
                      customtextfield(context, '', messageController),
                      const SizedBox(
                        height: 19,
                      )
                    ],
                  ),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 43, right: 42),
            child: GestureDetector(
              onTap: () {
                RegExp regExp = RegExp(emailPattern.trim());
                if (firstNameController.text.isEmpty) {
                  EasyLoading.showToast('Enter Your Name');
                } else if (lastNameController.text.isEmpty) {
                  EasyLoading.showToast('Enter Your Surname');
                } else if (emailController.text.isEmpty) {
                  EasyLoading.showToast('Enter Your Email Id');
                } else if (!regExp.hasMatch(emailController.text)) {
                  EasyLoading.showToast('Please Enter Valid Email Id');
                } else if (phoneController.text.isEmpty) {
                  EasyLoading.showToast('Enter Your Number');
                } else if (phoneController.text.length < 10) {
                  EasyLoading.showToast('Please Enter Valid Number');
                } else if (messageController.text.isEmpty) {
                  EasyLoading.showToast('Enter Your Message');
                } else {
                  callContactUsApi();
                }
              },
              child: Container(
                height: 51.14,
                width: 290,
                child: Neumorphic(
                  style: NeumorphicStyle(
                    color: neumorphicColor,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(27.5)),
                    intensity: 1,
                    depth: NeumorphicTheme.depth(context),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child:
                        getTtile('Submit', 14, FontWeight.w500, 'LabGrotesque'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customtextfield(
    BuildContext context,
    String hintText,
    TextEditingController controller,
  ) {
    return Neumorphic(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
      style: NeumorphicStyle(
          color: neumorphicColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(9)),
          intensity: 1,
          depth: NeumorphicTheme.embossDepth(context)),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
      child: Container(
        // alignment: Alignment.center,
        height: 119,
        width: 333,
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: black,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: black,
                  fontWeight: FontWeight.w400),
              hintText: hintText,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
