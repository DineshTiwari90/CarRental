import 'package:car_rental/modal/chatmodal.dart';
import 'package:car_rental/support/chatuser.dart';
import 'package:car_rental/support/customclipper.dart';
import 'package:car_rental/support/receiver.dart';
import 'package:car_rental/support/sendmessage.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportTeam extends StatefulWidget {
  const SupportTeam({Key? key}) : super(key: key);

  @override
  State<SupportTeam> createState() => _SupportTeamState();
}

class _SupportTeamState extends State<SupportTeam> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: neumorphicColor,
        title: getTtile('Support Team', 18, FontWeight.w500, 'LabGrotesque'),
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
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: ListView.separated(
                separatorBuilder: (context, i) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                reverse: true,
                itemCount: chatMessage.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 18),
                      child: chatMessage[index]['messageType'] == 'sender'
                          ? senderMessage(
                              context,
                              chatMessage[index]['img'],
                              chatMessage[index]['time'],
                              chatMessage[index]['msg'])
                          : receiverMessage(
                              context,
                              chatMessage[index]['img'],
                              chatMessage[index]['time'],
                              chatMessage[index]['msg']));
                },
              ),
            ),
            typemsgField(),
          ],
        ),
      ),
    );
  }

  Widget typemsgField() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 18, right: 18),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Neumorphic(
            style: NeumorphicStyle(
                color: neumorphicColor,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                intensity: 1,
                depth: NeumorphicTheme.depth(context)),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
            child: TextFormField(
              controller: messageController,
              cursorColor: Colors.black,
              style: const TextStyle(
                  fontFamily: 'LabGrotesque',
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
              decoration: InputDecoration(
                  hintText: "Type a message...",
                  helperStyle: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400, fontSize: 14),
                  border: InputBorder.none,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: InkWell(
                        onTap: () {
                          // To do
                        },
                        child: Image.asset(
                          'assets/images/send.png',
                        )),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Neumorphic neurphicmcontainer(double radius, Widget child) {
    return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          lightSource: LightSource.topLeft,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(radius)),
          intensity: 1,
          depth: NeumorphicTheme.depth(context),
          color: neumorphicColor),
      child: child,
    );
  }
}
