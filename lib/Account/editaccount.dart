import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:car_rental/apis/api.dart';
import 'package:car_rental/utils/capitallettes.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/utils/sharepreference.dart';
import 'package:car_rental/utils/validations.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAccount extends StatefulWidget {
  final String firstName;
  final String surName;
  final String emailId;
  final String photo;
  final String? phoneNumber;
  final String? age;
  final String? country;

  EditAccount(this.firstName, this.surName, this.emailId, this.photo,
      this.phoneNumber, this.age, this.country);

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  callUpdateProfileAPi() async {
    try {
      EasyLoading.show();
      final Uri uri = Uri.parse(baseUrl + updateProfileAPi);
      final http.MultipartRequest request = http.MultipartRequest(
        "PUT",
        uri,
      );
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken'
      });

      request.fields['name'] = firstNameController.text;
      request.fields['sur_name'] = lastNameController.text;
      request.fields['email'] = emailController.text;
      request.fields['phone_number'] = phoneController.text;
      request.fields['dob'] = ageController.text;
      request.fields['country'] = countryController.text;
      final fileSelfie =
          await http.MultipartFile.fromPath('profile_image', image!.path);
      request.files.add(fileSelfie);
      var res = await request.send();
      var vb = await http.Response.fromStream(res);
      var allJson = json.decode(vb.body);
      print(allJson);

      if (allJson['status'] == true) {
        setFirstName(firstNameController.text);
        setLastName(lastNameController.text);
        showInSnackBar(Colors.green, allJson['message'], context);
        Navigator.pop(context);
        EasyLoading.dismiss();
      } else {
        showInSnackBar(Colors.red, allJson['message'], context);
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e.toString());
    }
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid').toString();
    authToken = prefs.getString('auth_token').toString();
  }

  String userId = '';
  String authToken = '';

  File? image;
  @override
  void initState() {
    super.initState();
    getToken();
    initalControllerValue();
  }

  initalControllerValue() {
    firstNameController.text = widget.firstName;
    lastNameController.text = widget.surName;
    emailController.text = widget.emailId;
    phoneController.text = widget.phoneNumber.toString();
    ageController.text = widget.age.toString();
    countryController.text = widget.country.toString();
  }

  @override
  Widget build(BuildContext context) {
    print(authToken);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Edit Account', 16, FontWeight.w500, 'LabGrotesque'),
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
        padding: const EdgeInsets.only(top: 14),
        child: ListView(
          children: [
            profileWidget(width),
            const SizedBox(
              height: 23,
            ),
            Save(),
            const SizedBox(
              height: 31.86,
            ),
          ],
        ),
      ),
    );
  }

  Widget profileWidget(double width) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 19,
        right: 19,
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          width: width,
          child: Neumorphic(
            style: NeumorphicStyle(
                color: neumorphicColor,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                intensity: 1,
                depth: NeumorphicTheme.depth(context)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 22, left: 24, right: 23, bottom: 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      selectphotoDialogbox();
                    },
                    child: Align(
                      child: Container(
                        width: 110,
                        height: 110,
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              color: neumorphicColor,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(15)),
                              intensity: 1,
                              depth: NeumorphicTheme.depth(context)),
                          child: Container(
                            alignment: Alignment.center,
                            child: image != null
                                ? Image.file(
                                    image!,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : widget.photo.isNotEmpty && widget.photo != ''
                                    ? Image.network(
                                        widget.photo,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      )
                                    : Image.asset(
                                        'assets/images/camera.png',
                                        width: 35,
                                        height: 35,
                                      ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Align(
                      child: getTtile(
                          widget.firstName.capitalize() +
                              ' ' +
                              widget.surName.capitalize(),
                          16,
                          FontWeight.w500,
                          'LabGrotesque')),
                  const SizedBox(
                    height: 9,
                  ),
                  Align(
                      child: getTtile(
                          widget.emailId, 12, FontWeight.w500, 'LabGrotesque')),
                  const SizedBox(
                    height: 38,
                  ),
                  Container(
                    width: width,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: getTtile(
                                  'Name', 12, FontWeight.w500, 'LabGrotesque'),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            Container(
                                width: width / 2.5,
                                child: textfield(context, '', false,
                                    firstNameController, TextInputType.name, [
                                  FilteringTextInputFormatter(
                                      RegExp(r'[a-zA-Z]'),
                                      allow: true)
                                ])),
                          ],
                        ),
                        const SizedBox(
                          width: 19.81,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: getTtile('Surname', 12, FontWeight.w500,
                                    'LabGrotesque'),
                              ),
                              const SizedBox(
                                height: 11,
                              ),
                              Container(
                                  width: width / 2,
                                  child: textfield(context, '', false,
                                      lastNameController, TextInputType.name, [
                                    FilteringTextInputFormatter(
                                        RegExp(r'[a-zA-Z]'),
                                        allow: true)
                                  ])),
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
                    height: 11,
                  ),
                  textfield(context, '', false, emailController,
                      TextInputType.emailAddress, []),
                  const SizedBox(
                    height: 23,
                  ),
                  getTtile('Phone Number', 14, FontWeight.w500, 'LabGrotesque'),
                  const SizedBox(
                    height: 11,
                  ),
                  textfield(context, '', false, phoneController,
                      TextInputType.number, [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ]),
                  const SizedBox(
                    height: 23,
                  ),
                  getTtile('Age', 14, FontWeight.w500, 'LabGrotesque'),
                  const SizedBox(
                    height: 11,
                  ),
                  textfield(
                      context,
                      '',
                      false,
                      ageController,
                      TextInputType.number,
                      [FilteringTextInputFormatter.digitsOnly]),
                  const SizedBox(
                    height: 23,
                  ),
                  getTtile('Country of Residence', 14, FontWeight.w500,
                      'LabGrotesque'),
                  const SizedBox(
                    height: 11,
                  ),
                  countryField(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Save() {
    return InkWell(
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
        } else if (ageController.text.isEmpty) {
          EasyLoading.showToast('Enter Your Age');
        } else if (countryController.text.isEmpty) {
          EasyLoading.showToast('Enter Your Country');
        } else if (image == null && widget.photo.isEmpty) {
          EasyLoading.showToast('Select Your Profile Image');
        } else {
          callUpdateProfileAPi();
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 43, right: 42),
        height: 55,
        width: double.infinity,
        child: Neumorphic(
          style: NeumorphicStyle(
              color: neumorphicColor,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(27.5)),
              intensity: 12,
              depth: NeumorphicTheme.depth(context)),
          child: Align(
              alignment: Alignment.center,
              child: getTtile('Save', 14, FontWeight.w500, 'LabGrotesque')),
        ),
      ),
    );
  }

  Widget countryField() {
    return Neumorphic(
      margin: const EdgeInsets.only(left: 3, right: 8, top: 2, bottom: 4),
      style: NeumorphicStyle(
          color: neumorphicColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
          intensity: 1,
          depth: NeumorphicTheme.embossDepth(context)),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: Container(
        height: 55,
        alignment: Alignment.center,
        child: TextFormField(
          controller: countryController,
          autofocus: false,
          cursorColor: Colors.black,
          style: const TextStyle(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 15),
              prefixIcon: Container(
                width: 16,
                height: 12,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/country.png',
                  width: 16,
                  height: 12,
                ),
              ),
              hintText: '',
              border: InputBorder.none),
        ),
      ),
    );
  }

  selectphotoDialogbox() {
    return showModalBottomSheet(
        backgroundColor: backgroundcolor,
        shape: const RoundedRectangleBorder(
            // <-- SEE HERE
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(35.0),
        )),
        context: context,
        builder: (context) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 18, bottom: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTtile('Select', 14, FontWeight.w500, 'LabGrotesque'),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              pickImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 51.4,
                              width: 51.4,
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                    color: neumorphicColor,
                                    boxShape: const NeumorphicBoxShape.circle(),
                                    intensity: 1,
                                    depth: NeumorphicTheme.depth(context)),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/images/camera.png',
                                    width: 20,
                                    height: 18.4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          getTtile('Take a Picture', 12, FontWeight.w500,
                              'LabGrotesque'),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              pickImage(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 51.4,
                              width: 51.4,
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                    color: neumorphicColor,
                                    boxShape: const NeumorphicBoxShape.circle(),
                                    intensity: 1,
                                    depth: NeumorphicTheme.depth(context)),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/images/gallery.png',
                                    width: 20,
                                    height: 18.4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          getTtile('Photo Library', 12, FontWeight.w500,
                              'LabGrotesque'),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future pickImage(ImageSource source) async {
    var pickedFile;
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        this.image = tempImage;
      });
    } on PlatformException catch (e) {}
  }
}
