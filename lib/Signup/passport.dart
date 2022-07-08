import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:car_rental/Dashboard/dashboard.dart';
import 'package:car_rental/Home/bookingdetails.dart';
import 'package:car_rental/Signup/passportdocuments.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/utils/validations.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../apis/api.dart';
import '../widget/textfield.dart';

class Passport extends StatefulWidget {
  final String routesString1;
  Passport(this.routesString1);

  @override
  State<Passport> createState() => _PassportState();
}

class _PassportState extends State<Passport> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController countryController = TextEditingController();
  TextEditingController expireController = TextEditingController();
  TextEditingController passportController = TextEditingController();

  callUpdatePassportAPi() async {
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

      request.fields['passport_name'] = firstNameController.text;
      request.fields['passport_sur_name'] = lastNameController.text;
      request.fields['passport_no'] = passportController.text;
      request.fields['passport_expiry_date'] = expireController.text;
      request.fields['passport_country'] = countryController.text;
      final fileSelfie =
          await http.MultipartFile.fromPath('passport_photo', image!.path);
      request.files.add(fileSelfie);
      var res = await request.send();
      var vb = await http.Response.fromStream(res);
      var allJson = json.decode(vb.body);
      print(allJson);
      if (allJson['status'] == true) {
        showInSnackBar(Colors.green, allJson['message'], context);
        widget.routesString1 == 'selectdatetime'
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const BookindDetails()))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const PassPortDocument()));
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
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Passport', 16, FontWeight.w500, 'LabGrotesque'),
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
        padding: const EdgeInsets.only(),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    lightSource: LightSource.topLeft,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                    intensity: 1,
                    color: neumorphicColor),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 6.66, left: 15, right: 12, bottom: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTtile('Passport Details', 14, FontWeight.w500,
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
                                    child: textfield(
                                        context,
                                        '',
                                        false,
                                        firstNameController,
                                        TextInputType.name, [])),
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
                                          TextInputType.name, [])),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      getTtile('Country', 12, FontWeight.w500, 'LabGrotesque'),
                      const SizedBox(
                        height: 3,
                      ),
                      textfield(context, '', false, countryController,
                          TextInputType.name, []),
                      const SizedBox(
                        height: 9,
                      ),
                      getTtile('Passport Number', 12, FontWeight.w500,
                          'LabGrotesque'),
                      const SizedBox(
                        height: 3,
                      ),
                      customTextField(
                        context,
                        '',
                        false,
                        passportController,
                        TextInputType.text,
                        [FilteringTextInputFormatter.allow(RegExp("[0-9a-z]"))],
                      ),
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
                        height: 19,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: getTtile(
                  'Upload Your Passport', 14, FontWeight.w500, 'LabGrotesque'),
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
            Submit(),
            const SizedBox(
              height: 25,
            ),
            widget.routesString1 == 'selectdatetime' ? Container() : Skip(),
            const SizedBox(
              height: 46,
            )
          ],
        ),
      ),
    );
  }

  Widget Skip() {
    return Container(
      child: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
          },
          child: getTtile('Skip', 14, FontWeight.w500, 'LabGrotesque')),
    );
  }

  Widget Submit() {
    return InkWell(
      onTap: () {
        if (firstNameController.text.isEmpty) {
          EasyLoading.showToast('Enter Your Name');
        } else if (lastNameController.text.isEmpty) {
          EasyLoading.showToast('Enter Your Surname');
        } else if (countryController.text.isEmpty) {
          EasyLoading.showToast('Enter Your Country');
        } else if (passportController.text.isEmpty) {
          EasyLoading.showToast('Enter Your Passport Number');
        } else if (expireController.text.isEmpty) {
          EasyLoading.showToast('Enter Expiry Date');
        } else if (image == null) {
          EasyLoading.showToast('Upload Your Passport Image');
        } else {
          callUpdatePassportAPi();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 43, right: 42),
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
                child: getTtile('Submit', 14, FontWeight.w500, 'LabGrotesque')),
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

  Widget uploadinglicence() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Container(
        width: double.infinity,
        child: Neumorphic(
          style: NeumorphicStyle(
              color: neumorphicColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
              intensity: 1,
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
                          child: Image.asset(
                            'assets/images/close.png',
                            width: 15,
                            height: 15,
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
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Container(
        height: 200,
        child: Neumorphic(
          style: NeumorphicStyle(
              color: neumorphicColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
              intensity: 1,
              depth: NeumorphicTheme.embossDepth(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  selectphotoDialogbox();
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
          autofocus: false,
          cursorColor: Colors.black,
          style: const TextStyle(
              fontSize: 12, color: black, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              prefixIcon: Container(
                width: 5.5,
                height: 16.5,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/country.png',
                  width: 5.5,
                  height: 16.5,
                ),
              ),
              hintText: 'United Arab Emirates',
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
