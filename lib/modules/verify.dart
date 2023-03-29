import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';
import 'package:resturantapp/controlers/verify_controller.dart';
import 'package:resturantapp/modles/PhoneNumber_Auth.dart';
import '../shared/componenets/componenet.dart';
import '../shared/data_resource/cloud/cloud_controller.dart';

class Verify extends GetView<CloudController> {
  String? name;
  String? pass;
  String? phone;
  Verify({this.name,this.pass, this.phone});

  var verifyController = Get.put(VerifyController());
  var _form = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed("/forgetPass");

        return false;
      },
      child: Form(
        key: _form,
        child: Scaffold(
          body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // Curved Draw
                        Container(
                          height: 250,
                          width: double.infinity,
                          child: CustomPaint(
                            painter: CurvePainter(),
                          ),
                        ),

                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Get.offAllNamed("/forgetPass");
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            ),
                            Image.asset(
                              "assets/images/mainlogo.png",
                              width: 170,
                              height: 170,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          // Text View
                          Text(
                            "You will receive a 6-digit text message To \n confirm  the account, enter it",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(112, 112, 112, 1),
                                fontFamily: "SF-Pro",
                                shadows: [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.16),
                                      blurRadius: 6,
                                      offset: Offset(0, 3))
                                ],
                                fontWeight: FontWeight.w500),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.030,
                          ),

                          // عند انتهاء الوقت اخفاء المؤقت
                          GetBuilder<VerifyController>(
                            builder: (context)=>verifyController.secounds==0?SizedBox()
                                :  buildTimer(),
                          ),


                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.030,
                          ),


                          // Input Verify Number
                          Pinput(
                            length: 6,
                            // // defaultPinTheme: defaultPinTheme,
                            // focusedPinTheme: focusedPinTheme,
                            // // submittedPinTheme: submittedPinTheme,
                            onChanged: (value) {
                              verifyController.onChageInput(value);
                            },
                            showCursor: true,
                            onCompleted: (pin) => print(pin),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.055,
                          ),


                          GetBuilder<VerifyController>(builder: (_)=> getDefaultButton(
                              text: "Verify",
                              textColor: Color.fromRGBO(112, 112, 112, 1),
                              isShadow: true,
                              isGradinent: true,
                              function: () async {

                                PhoneNumber_Auth.verifyedCode(context, verifyController.smsCode);
                                await controller.saveUsersInfo(PhoneNumber_Auth.uid!,name!, phone!, pass!, context);

                              }),),



                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.030,
                          ),

                          // عند انتهاء المؤقت يتم عرض زر اعادة الارسال
                          GetBuilder<VerifyController>(
                              builder: (context)=>verifyController.secounds==0?getDefaultButton(
                                  text: "Re Send",
                                  textColor: Color.fromRGBO(112, 112, 112, 1),
                                  isShadow: true,
                                  isGradinent: true,
                                  function: () {
                                    verifyController.secounds=VerifyController.maxSecound;
                                    verifyController.startTimer();
                                  })
                                  : SizedBox(),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ميثود بناء المؤقت
  Widget buildTimer()=>
      GetBuilder<VerifyController>(
      builder: (context)=>SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: verifyController.secounds/VerifyController.maxSecound,
              strokeWidth: 6,
            ),
            Center(
              child: Text('${verifyController.secounds}',
                style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.w700),),
            ),
          ],
        ),
      ));




}

// Class to Draw Curve
class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.style = PaintingStyle.fill; // Change this to fill

    // Define your gradient color stops
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(242, 221, 128, 1)!,
        Color.fromRGBO(199, 143, 64, 1)!,
      ],
      stops: [0.007, 0.6],
    );

    // Set your gradient color to paint object
    paint.shader =
        gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    var path = Path();

    path.moveTo(0, size.height * 0.61);
    path.quadraticBezierTo(
        size.width / 2, size.height / 0.93, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


