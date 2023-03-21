import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resturantapp/controlers/verify_controller.dart';
import '../shared/componenets/componenet.dart';

class Verify extends StatelessWidget {
  Verify({Key? key}) : super(key: key);

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
                          height: MediaQuery.of(context).size.height * 0.055,
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.055,
                        ),

                        getDefaultButton(
                            text: "Send",
                            textColor: Color.fromRGBO(112, 112, 112, 1),
                            isShadow: true,
                            isGradinent: true,
                            function: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
