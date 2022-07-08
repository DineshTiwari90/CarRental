import 'package:car_rental/utils/constants.dart';
import 'package:car_rental/widget/gettitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'homescreen.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List suggestions = ["BMW", "Aston Martin", "Ferrari"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: ListView(
        shrinkWrap: true,
        children: [
          heading(),
          const SizedBox(
            height: 25,
          ),
          searchBar(),
          const SizedBox(
            height: 21,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 18,
            ),
            child: getTtile('Suggestion', 14, FontWeight.w500, 'LabGrotesque'),
          ),
          const SizedBox(
            height: 17,
          ),
          suggestionList(),
          const SizedBox(
            height: 23,
          ),
          recentSearch()
        ],
      ),
    );
  }

  Widget recentSearch() {
    return Container(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      child: Neumorphic(
        style: NeumorphicStyle(
            color: neumorphicColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            intensity: 1,
            depth: NeumorphicTheme.depth(context)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 8, right: 5, bottom: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getTtile('Recently Search', 14, FontWeight.w500, 'LabGrotesque'),
              const SizedBox(
                height: 28,
              ),
              recentlyResult('BMW'),
              const SizedBox(
                height: 21,
              ),
              recentlyResult('Aston Martin'),
              const SizedBox(
                height: 21,
              ),
              recentlyResult('Ferrari')
            ],
          ),
        ),
      ),
    );
  }

  recentlyResult(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
              Image.asset(
                'assets/images/refresh.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(
                width: 9,
              ),
              getTtile(title, 12, FontWeight.w300, 'LabGrotesque'),
            ],
          ),
        ),
        Image.asset(
          'assets/images/arrow_right.png',
          width: 18,
          height: 18,
        )
      ],
    );
  }

  Widget suggestionList() {
    return Container(
      height: 39,
      child: ListView.separated(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
          ),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 18);
          },
          itemCount: suggestions.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: 100,
              child: Neumorphic(
                style: NeumorphicStyle(
                    color: neumorphicColor,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    intensity: 1,
                    depth: NeumorphicTheme.depth(context)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(suggestions[index].toString()),
                ),
              ),
            );
          }),
    );
  }

  Widget heading() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getTtile('Search Car', 14, FontWeight.w500, 'Lab Grotesque'),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/close.png'))),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      child: Neumorphic(
        margin: const EdgeInsets.only(left: 3, right: 8, top: 2, bottom: 4),
        style: NeumorphicStyle(
            color: backgroundcolor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            intensity: 1,
            depth: NeumorphicTheme.embossDepth(context)),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        child: TextFormField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search Your Car',
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color(0xffC7C6C6),
                  fontFamily: 'LabGrotesque',
                  fontSize: 12),
              suffixIcon: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/search.png',
                  width: 20,
                  height: 20,
                ),
              )),
        ),
      ),
    );
  }
}
