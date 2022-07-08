import 'dart:convert';
import 'dart:io';

import 'package:car_rental/Signup/drivinglicencedocuments.dart';
import 'package:car_rental/Signup/passport.dart';
import 'package:car_rental/apis/api.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/utils/validations.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrivingLicence extends StatefulWidget {
  final String routesString1;
  final String routeString2;
  DrivingLicence(this.routesString1, this.routeString2);
  @override
  State<DrivingLicence> createState() => _DrivingLicenceState();
}

class _DrivingLicenceState extends State<DrivingLicence> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController categoryController = TextEditingController();
  TextEditingController expireController = TextEditingController();
  TextEditingController drivingController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  callDrivingLicenseAPi() async {
    try {
      EasyLoading.show();
      final Uri uri = Uri.parse(baseUrl + updatePassDrivLicenceApi);
      final http.MultipartRequest request = http.MultipartRequest(
        "PUT",
        uri,
      );
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken'
      });

      request.fields['license_name'] = firstNameController.text;
      request.fields['license_sur_name'] = lastNameController.text;
      request.fields['license_no'] = drivingController.text;
      request.fields['expiry_date'] = expireController.text;
      request.fields['country'] = countryController.text;
      request.fields['license_category'] = categoryController.text;
      final fileSelfie =
          await http.MultipartFile.fromPath('license_photo', image!.path);
      request.files.add(fileSelfie);
      var res = await request.send();
      print(res);
      var vb = await http.Response.fromStream(res);
      var allJson = json.decode(vb.body);
      print(allJson);

      if (allJson['status'] == true) {
        showInSnackBar(Colors.green, allJson['message'], context);
        widget.routesString1 == 'selectdatetime'
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Passport('selectdatetime')))
            : widget.routeString2 == 'signup'
                ? Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Passport('')))
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DrivingLicenseDocuments()));

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
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: neumorphicColor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Driving License', 16, FontWeight.w500, 'LabGrotesque'),
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
      body: ListView(
        children: [
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 20,
            ),
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
                    top: 6.66, left: 15, right: 12, bottom: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTtile('Driving License Details', 14, FontWeight.w500,
                        'LabGrotesque'),
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                      width: width,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: getTtile('Name', 12, FontWeight.w500,
                                    'LabGrotesque'),
                              ),
                              const SizedBox(
                                height: 13,
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
                            width: 16.65,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: getTtile('Surname', 12,
                                      FontWeight.w500, 'LabGrotesque'),
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                Container(
                                    width: width / 2,
                                    child: textfield(
                                        context,
                                        '',
                                        false,
                                        lastNameController,
                                        TextInputType.name, [
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
                      height: 9,
                    ),
                    getTtile('Driving License Number', 12, FontWeight.w500,
                        'LabGrotesque'),
                    const SizedBox(
                      height: 3,
                    ),
                    customTextField(context, '', false, drivingController,
                        TextInputType.text, [
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-z]"))
                    ]),
                    const SizedBox(
                      height: 9,
                    ),
                    getTtile(
                        'Expiry Date', 12, FontWeight.w500, 'LabGrotesque'),
                    const SizedBox(
                      height: 9,
                    ),
                    textfield(context, '', false, expireController,
                        TextInputType.datetime, [
                      FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
                      LengthLimitingTextInputFormatter(10),
                    ]),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      height: 33,
                      width: 99,
                      child: getTtile('Country Of Issue', 12, FontWeight.w500,
                          'LabGrotesque'),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text.rich(
                      TextSpan(
                        text: 'Attention:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                        children: [
                          TextSpan(
                              text:
                                  "For Residents of (UAE) It's  Mandatory To Attach And Keep At All Times The International Version Of The Driving License. Please Make Sure You Have It Prior To The Booking.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  letterSpacing: -0.17,
                                  wordSpacing: -0.165,
                                  color: black),
                              children: [
                                TextSpan(
                                    text: ' Get In Touch To Know More.',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red))
                              ]),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    countryField(),
                    const SizedBox(
                      height: 9,
                    ),
                    getTtile('Category', 12, FontWeight.w500, 'LabGrotesque'),
                    const SizedBox(
                      height: 3,
                    ),
                    textfield(context, '', false, categoryController,
                        TextInputType.name, [])
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 19,
              right: 10,
            ),
            child: getTtile('Upload Your Driving License', 14, FontWeight.w500,
                'LabGrotesque'),
          ),
          const SizedBox(
            height: 4,
          ),
          uploadDrivingLicense(),
          const SizedBox(
            height: 18,
          ),
          uploadinglicence(),
          const SizedBox(
            height: 26,
          ),
          continueButton(),
          const SizedBox(
            height: 22.86,
          )
        ],
      ),
    );
  }

  Widget continueButton() {
    return GestureDetector(
      onTap: () {
        if (firstNameController.text.isEmpty) {
          EasyLoading.showToast('Enter Your Name');
        } else if (lastNameController.text.isEmpty) {
          EasyLoading.showToast('Enter Your Surname');
        } else if (drivingController.text.isEmpty) {
          EasyLoading.showToast('Enter Your License Number');
        } else if (expireController.text.isEmpty) {
          EasyLoading.showToast('Enter Expiry Date');
        } else if (countryController.text.isEmpty) {
          EasyLoading.showToast('Enter Your Country');
        } else if (categoryController.text.isEmpty) {
          EasyLoading.showToast('Enter Your License Category');
        } else if (image == null) {
          EasyLoading.showToast('Upload Your Driving License');
        } else {
          callDrivingLicenseAPi();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 41),
        child: Container(
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
                child:
                    getTtile('Continue', 14, FontWeight.w500, 'LabGrotesque')),
          ),
        ),
      ),
    );
  }

  Widget uploadinglicence() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
        ),
        child: Neumorphic(
          style: NeumorphicStyle(
              color: neumorphicColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
              intensity: 12,
              depth: NeumorphicTheme.depth(context)),
          child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 14, left: 13, right: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTtile('Uploading', 12, FontWeight.w500, 'LabGrotesque'),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              getTtile(
                                  '62%', 12, FontWeight.w400, 'LabGrotesque'),
                              const SizedBox(
                                width: 8,
                              ),
                              getTtile('12 Second Remaining', 12,
                                  FontWeight.w400, 'LabGrotesque'),
                            ],
                          ),
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          child: Image.asset(
                            'assets/images/close.png',
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    const LinearProgressIndicator(
                      value: 1,
                      backgroundColor: Color(0xffD9D5D5),
                      color: Colors.red,
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget uploadDrivingLicense() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      child: Neumorphic(
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            intensity: 1,
            depth: NeumorphicTheme.embossDepth(context)),
        child: Container(
          height: 200,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  selectlicenseDialogbox();
                },
                child: Container(
                  height: 78,
                  width: 78,
                  child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(50),
                      padding: const EdgeInsets.all(6),
                      color: const Color(0xff9C9B9B),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(22)),
                        child: Container(
                            alignment: Alignment.center,
                            child: image != null
                                ? Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                : Image.asset(
                                    'assets/images/addicon.png',
                                    width: 29.9,
                                    height: 29.9,
                                  )),
                      )),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              getTtile('Click a Photo / Upload From Gallery', 12,
                  FontWeight.w500, 'LabGrotesque'),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField(
    BuildContext context,
    String hintText,
    bool readOnly,
    TextEditingController controller,
    TextInputType textInputType,
    List<TextInputFormatter>? inputFormatters,
  ) {
    return Neumorphic(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
      style: NeumorphicStyle(
          color: neumorphicColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
          intensity: 1,
          depth: NeumorphicTheme.embossDepth(context)),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
      child: Container(
        alignment: Alignment.center,
        height: 55,
        child: TextFormField(
          textCapitalization: TextCapitalization.characters,
          keyboardType: textInputType,
          controller: controller,
          inputFormatters: inputFormatters,
          readOnly: readOnly,
          autofocus: false,
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

  Widget countryField() {
    return Neumorphic(
      margin: const EdgeInsets.only(left: 3, right: 8, top: 2, bottom: 4),
      style: NeumorphicStyle(
          color: neumorphicColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(9)),
          intensity: 1,
          depth: NeumorphicTheme.embossDepth(context)),
      padding: const EdgeInsets.only(),
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
              contentPadding: const EdgeInsets.only(top: 17),
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

  selectlicenseDialogbox() {
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
