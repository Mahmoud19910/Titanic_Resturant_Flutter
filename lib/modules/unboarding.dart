import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resturantapp/modules/SignUp.dart';
import '../controlers/unboad_controller.dart';
import '../shared/componenets/componenet.dart';
import '../shared/constant/constant_component.dart';

class UnBoarding extends StatelessWidget {
  var unboardingCintoller = Get.put(UnboardingController());
  ConstantComponenet constantComponenet = ConstantComponenet();
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(135)),
            color: Color.fromRGBO(0, 0, 0, 0.16),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(0, 6), // changes position of shadow
              ),
            ]),
        child: PageView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          itemBuilder: (context, postion) => ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(135)),
            child: Image.asset(
              constantComponenet.getUnBoardingImage()[postion].assetName,
              fit: BoxFit.fill,
            ),
          ),
          onPageChanged: (value) {
            unboardingCintoller.setChanged(value);
            unboardingCintoller.setTilteAndDesc();
          },
        ),
      ),

      SizedBox(
        height: MediaQuery.of(context).size.height * 0.032,
      ),
// Indicator

      GetBuilder<UnboardingController>(
        builder: (controller) =>
            getIndicatorShap(unboardingCintoller.indexPagerView),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.032,
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          children: [
            GetBuilder<UnboardingController>(
              builder: (controller) => SizedBox(
                height: 65,
                child: getDefaultText(
                    text: unboardingCintoller.title,
                    fontSize: 28,
                    color: Color.fromRGBO(240, 191, 108, 1),
                    setShadow: true,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.032,
            ),
            GetBuilder<UnboardingController>(
              builder: (controller) => SizedBox(
                height: 60,
                child: getDefaultText(
                    text: unboardingCintoller.decription,
                    fontSize: 17,
                    color: Color.fromRGBO(112, 112, 112, 1),
                    setShadow: false,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.078,
            ),
            Row(
              children: [
                getGradinetButton(
                    text: "Sign Up",
                    isGradient: true,
                    color: Colors.white,
                    isBorder: true,
                    function: () {
                      // Get.to(SignUp());
                      Get.offAllNamed("/signup");
                    }),
                SizedBox(
                  width: 10,
                ),
                getGradinetButton(
                    text: "Sign In",
                    isGradient: false,
                    color: Color.fromRGBO(0, 112, 112, 1),
                    isBorder: true)
              ],
            ),
          ],
        ),
      )
    ]
                )
        )
    );
  }
}
