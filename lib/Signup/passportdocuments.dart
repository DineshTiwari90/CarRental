import 'dart:convert';
import 'dart:developer';

import 'package:car_rental/Signup/drivinglicence.dart';
import 'package:car_rental/apis/api.dart';
import 'package:car_rental/modal/profileModal.dart';
import 'package:car_rental/utils/capitallettes.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/utils/validations.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PassPortDocument extends StatefulWidget {
  const PassPortDocument({Key? key}) : super(key: key);

  @override
  State<PassPortDocument> createState() => _PassPortDocumentState();
}

class _PassPortDocumentState extends State<PassPortDocument> {
  callgetPassportAPI(String authToken) async {
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
        userProfileList.passportName = dataAll['result']['passport_name'];
        userProfileList.passportSurName =
            dataAll['result']['passport_sur_name'];
        userProfileList.passportNo = dataAll['result']['passport_no'];
        userProfileList.passportExpiryDate =
            dataAll['result']['passport_expiry_date'];
        userProfileList.passportCountry = dataAll['result']['passport_country'];

        if (dataAll['result']['passport_photo'] != null &&
            dataAll['result']['passport_photo'] != '') {
          userProfileList.passportPhoto = dataAll['result']['passport_photo'];
          for (int i = 0; i < userProfileList.passportPhoto!.length; i++) {
            passportImg = userProfileList.passportPhoto![i];
          }
        }

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
    callgetPassportAPI(prefs.getString('auth_token').toString());
  }

  var userProfileList = ProfileModal();

  @override
  void initState() {
    getToken();
    super.initState();
  }

  String userId = '';
  String authToken = '';

  String passportImg = '';

  @override
  Widget build(BuildContext context) {
    print(passportImg);
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        centerTitle: true,
        title: getTtile('Documents', 16, FontWeight.w500, 'LabGrotesque'),
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
        padding: const EdgeInsets.only(top: 14, left: 18, right: 19),
        child: Column(
          children: [
            drivingLicenseWidget(),
            const SizedBox(
              height: 18,
            ),
            passportDocuments()
          ],
        ),
      ),
    );
  }

  Widget drivingLicenseWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DrivingLicence('passportdoc', 'passportdoc')));
      },
      child: Container(
        height: 51.14,
        width: double.infinity,
        child: Neumorphic(
          style: NeumorphicStyle(
              color: neumorphicColor,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
              intensity: 1,
              depth: NeumorphicTheme.depth(context)),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getTtile(
                    'Driving License', 14, FontWeight.w500, 'LabGrotesque'),
                Container(
                  child: Image.asset(
                    'assets/images/backfill.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget passportDocuments() {
    return Container(
      child: Neumorphic(
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            intensity: 1,
            depth: NeumorphicTheme.depth(context)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 17, left: 13, right: 10, bottom: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTtile('Passport', 14, FontWeight.w500, 'LabGrotesque'),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/arrow_down.png',
                      width: 24,
                      height: 24,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              documentField(
                  'Name',
                  userProfileList.passportName != null
                      ? userProfileList.passportName.toString().capitalize()
                      : '-'),
              const SizedBox(
                height: 23,
              ),
              documentField(
                  'Surname',
                  userProfileList.passportSurName != null
                      ? userProfileList.passportSurName.toString().capitalize()
                      : '-'),
              const SizedBox(
                height: 23,
              ),
              documentField('Country', userProfileList.passportCountry ?? "-"),
              const SizedBox(
                height: 23,
              ),
              documentField(
                  'Passport Number', userProfileList.passportNo ?? "-"),
              const SizedBox(
                height: 23,
              ),
              documentField('Expiry Date', userProfileList.expiryDate ?? "-"),
              const SizedBox(
                height: 28,
              ),
              Container(
                height: 176,
                width: 312,
                child: Neumorphic(
                  style: NeumorphicStyle(
                      color: neumorphicColor,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(15)),
                      intensity: 1,
                      depth: NeumorphicTheme.depth(context)),
                  child: passportImg.isNotEmpty && passportImg != ''
                      ? Image.network(
                          passportImg,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Image.asset('assets/images/passportimg.png'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget documentField(String title, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getTtile(title, 12, FontWeight.w500, 'LabGrotesque'),
        getTtile(text, 12, FontWeight.w500, 'LabGrotesque')
      ],
    );
  }
}
