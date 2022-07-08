import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/Account/changepassword.dart';
import 'package:car_rental/Account/editaccount.dart';
import 'package:car_rental/apis/api.dart';
import 'package:car_rental/modal/profileModal.dart';
import 'package:car_rental/utils/capitallettes.dart';
import 'package:car_rental/utils/sharepreference.dart';
import 'package:car_rental/utils/validations.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:car_rental/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class SidebarProfile extends StatefulWidget {
  const SidebarProfile({Key? key}) : super(key: key);

  @override
  State<SidebarProfile> createState() => _SidebarProfileState();
}

class _SidebarProfileState extends State<SidebarProfile> {
  TextEditingController emailController = TextEditingController();
  callgetProfileAPI(String authToken) async {
    try {
      EasyLoading.show();
      var response = await http.get(
        Uri.parse(baseUrl + getProfileAPi),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );

      log(response.body);
      var dataAll = json.decode(response.body);
      if (dataAll['status'] == true) {
        // showInSnackBar(Colors.green, dataAll['message'], context);
        userProfileList.name = dataAll['result']['name'];
        userProfileList.surName = dataAll['result']['sur_name'];
        userProfileList.email = dataAll['result']['email'];
        userProfileList.phoneNumber = dataAll['result']['phone_number'];
        userProfileList.country = dataAll['result']['country'];
        userProfileList.dob = dataAll['result']['dob'];
        if (dataAll['result']['profile_image'] != null &&
            dataAll['result']['profile_image'] != '') {
          userProfileList.profileImage = dataAll['result']['profile_image'];
          for (int i = 0; i < userProfileList.profileImage!.length; i++) {
            setProfileimg(userProfileList.profileImage![i]);
            userImg = userProfileList.profileImage![i];
          }
        }
        setFirstName(dataAll['result']['name']);
        setLastName(dataAll['result']['sur_name']);

        setState(() {});
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
    userId = prefs.getString('userid').toString();
    authToken = prefs.getString('auth_token').toString();
    callgetProfileAPI(prefs.getString('auth_token').toString());
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  String userId = '';
  String authToken = '';

  String userImg = '';

  callInviteFriendAPI() async {
    var body = json.encode({'email': emailController.text, 'user_id': userId});

    try {
      EasyLoading.show();
      var response = await http.post(
        Uri.parse(baseUrl + inviteFriendAPi),
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
        emailController.clear();
        EasyLoading.dismiss();
      } else {
        emailController.clear();
        showInSnackBar(Colors.red, dataAll['message'], context);
        EasyLoading.dismiss();
      }
    } catch (e) {
      print(e.toString());
      EasyLoading.dismiss();
    }
  }

  var userProfileList = ProfileModal();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        title: getTtile('', 18, FontWeight.w500, 'LabGrotesque'),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: black,
            )),
      ),
      backgroundColor: neumorphicColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            profileWidget(width),
            const SizedBox(
              height: 94,
            ),
            customtextfield(context, 'Enter Email id', false, emailController,
                TextInputType.emailAddress, []),
            const SizedBox(
              height: 22,
            ),
            InviteButton(),
            const SizedBox(
              height: 26.86,
            )
          ],
        ),
      ),
    );
  }

  Widget InviteButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 43, right: 42),
      child: GestureDetector(
        onTap: () {
          RegExp regExp = RegExp(emailPattern.trim());
          if (emailController.text.isEmpty) {
            EasyLoading.showToast('Enter your email id');
          } else if (!regExp.hasMatch(emailController.text)) {
            EasyLoading.showToast('Please enter valid email id');
          } else {
            callInviteFriendAPI();
          }
        },
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
                child: getTtile(
                    'Invite A Friend', 14, FontWeight.w500, 'LabGrotesque')),
          ),
        ),
      ),
    );
  }

  Widget profileWidget(double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 19, top: 14, right: 14),
      child: Container(
        width: width,
        child: Neumorphic(
          style: NeumorphicStyle(
              color: neumorphicColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
              intensity: 1,
              depth: NeumorphicTheme.depth(context)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 22, left: 23, right: 24, bottom: 25),
            child: Column(
              children: [
                Container(
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
                      child: userImg.isNotEmpty && userImg != ''
                          ? CachedNetworkImage(
                              imageUrl: userImg,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: double.infinity,
                              placeholder: (context, url) {
                                return const CircularProgressIndicator(
                                  color: Colors.red,
                                );
                              },
                              errorWidget: (context, url, error) => Container(
                                width: 35,
                                height: 35,
                                child: Image.asset(
                                  'assets/images/Profile.png',
                                  width: 35,
                                  height: 35,
                                ),
                              ),
                            )
                          : Image.asset(
                              'assets/images/Profile.png',
                              width: 35,
                              height: 35,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                getTtile(
                    userProfileList.name != null &&
                            userProfileList.surName != null
                        ? userProfileList.name.toString().capitalize() +
                            ' ' +
                            userProfileList.surName.toString().capitalize()
                        : '',
                    16,
                    FontWeight.w500,
                    'LabGrotesque'),
                const SizedBox(
                  height: 9,
                ),
                getTtile(
                    userProfileList.email != null
                        ? userProfileList.email.toString()
                        : '',
                    12,
                    FontWeight.w500,
                    'LabGrotesque'),
                const SizedBox(
                  height: 9,
                ),
                getTtile(
                    '1000Km - Beginner', 12, FontWeight.w500, 'LabGrotesque'),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditAccount(
                                      userProfileList.name ?? '',
                                      userProfileList.surName ?? '',
                                      userProfileList.email ?? '',
                                      userImg,
                                      userProfileList.phoneNumber ?? '',
                                      userProfileList.dob ?? "",
                                      userProfileList.country ?? '')))
                          .then((value) {
                        getToken();
                      });
                    },
                    child: buildButton('Edit Account')),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword()));
                    },
                    child: buildButton('Change Password'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(String title) {
    return Container(
      height: 55,
      width: double.infinity,
      child: Neumorphic(
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            intensity: 12,
            depth: NeumorphicTheme.depth(context)),
        child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTtile(title, 14, FontWeight.w500, 'LabGrotesque'),
                  Container(
                    child: Image.asset(
                      'assets/images/backfill.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget customtextfield(
    BuildContext context,
    String hintText,
    bool readOnly,
    TextEditingController controller,
    TextInputType textInputType,
    List<TextInputFormatter>? inputFormatters,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 43, right: 42),
      child: Neumorphic(
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
      ),
    );
  }
}
