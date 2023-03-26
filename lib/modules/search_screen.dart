import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../shared/componenets/componenet.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [

            //App Bar
            Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              color: Color.fromRGBO(227, 227, 227, 1),
              child: Padding(
                padding: const EdgeInsets.only(right: 5, left: 5),
                child: Row(
                  children: [
                    // Notifications
                    Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                Color.fromRGBO(242, 221, 128, 1),
                                Color.fromRGBO(199, 143, 64, 1)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ).createShader(bounds);
                          },
                          child: Icon(Icons.notifications,
                              size: 31, color: Colors.white),
                        ),
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            "1",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),

                    Expanded(child: SizedBox()),

                    // Title
                    Container(
                      height: 45,
                      width: 280,
                      child: SearchBarAnimation(
                        textEditingController: TextEditingController(),
                        isOriginalAnimation: true,
                        enableKeyboardFocus: true,
                        onExpansionComplete: () {
                          debugPrint(
                              'do something just after searchbox is opened.');
                        },
                        onCollapseComplete: () {
                          debugPrint(
                              'do something just after searchbox is closed.');
                        },
                        onPressButton: (isSearchBarOpens) {
                          debugPrint(
                              'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
                        },

                        trailingWidget: const Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.black,
                        ),
                        secondaryButtonWidget: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black,
                        ),
                        buttonWidget: const Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),

                    // Drawer Layout
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(242, 221, 128, 1),
                                Color.fromRGBO(199, 143, 64, 1)
                              ])),
                      child: Icon(
                        Icons.format_list_bulleted,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
