import 'package:car_rental/login/Intro/contentmodal.dart';
import 'package:car_rental/login/signIn.dart';
import 'package:car_rental/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;

  PageController pageController = PageController();
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: backgroundcolor,
        ),
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                child: Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: [
                            taier1color.withOpacity(0.31),
                            taier2color.withOpacity(1.0)
                          ],
                        ).createShader(bounds);
                      },
                      child: Image.asset(
                        'assets/images/taier.png',
                        width: 154,
                        // height: 303,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: [
                            taier1color.withOpacity(0.31),
                            taier2color.withOpacity(1.0)
                          ],
                        ).createShader(bounds);
                      },
                      child: Image.asset(
                        'assets/images/taier.png',
                        width: 154,
                      ),
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 505,
                width: 339,
                child: Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                      intensity: 12,
                      shadowLightColor: const Color(0xffFAF9F9),
                      color: neumorphicColor),
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: contents.length,
                      onPageChanged: (int index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 49, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      contents[i].image,
                                      height: 188,
                                      width: 250,
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      contents[i].title,
                                      style: const TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 21),
                                    Text(
                                      contents[i].discription,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12,
                                        color: Color(0xFF000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 17, right: 17),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          contents.length,
                                          (index) => buildDot(index, context),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignIn()));
                                      },
                                      child: Container(
                                        width: 94,
                                        height: 41,
                                        // color: Color(0xffE5E5E5),
                                        child: Neumorphic(
                                            style: NeumorphicStyle(
                                                shape: NeumorphicShape.concave,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                        BorderRadius.circular(
                                                            300)),
                                                // depth: 8,
                                                intensity: 12,
                                                depth: NeumorphicTheme.depth(
                                                    context),
                                                color: neumorphicColor),
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "SKIP",
                                                style: TextStyle(
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff000000)),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 4,
      width: currentIndex == index ? 29 : 11,
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: currentIndex == index
            ? const Color(0xff161821)
            : const Color(0xffC4C4C4),
      ),
    );
  }
}
