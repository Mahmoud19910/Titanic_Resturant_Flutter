import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resturantapp/controlers/forgetpass_controller.dart';
import 'package:resturantapp/shared/componenets/componenet.dart';

class ForgetPass extends StatelessWidget {
  ForgetPass({Key? key}) : super(key: key);
  var forgetController=Get.put(ForgetPassController());
  TextEditingController newPssEdit=new TextEditingController();
  TextEditingController phoneEdit=new TextEditingController();
  var _form=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Get.offAllNamed("/signIn");

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
                                      onTap: (){
                                        Get.offAllNamed("/signIn");
                                      },
                                      child: Icon(Icons.arrow_back_ios_new , color: Colors.white,))
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
                          getDefaultText(text: "Forget Passowrd",
                              fontSize: 28,
                              color: Color.fromRGBO(112, 112, 112, 1),
                              setShadow: true,
                              fontWeight: FontWeight.w500),


                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.055,
                          ),

                          // New Pass Editing
                          GetBuilder<ForgetPassController>(

                            builder: (context)=>getDefaultTextFiled(
                                keyBoardType: TextInputType.visiblePassword,
                                isBorder: false,
                                text: "New Passowrd",
                                isGradient: true,
                                controller:newPssEdit ,
                                showPass:forgetController.showPass ,
                                validatorFunc: validateInput,
                                showPassFunc: () {
                                  forgetController.showPassFunc();
                                },
                                sufixIcon: forgetController.showPass
                                    ? Icons.visibility_off_outlined
                                    : Icons.remove_red_eye_outlined,
                                inputType: TextInputType.name),),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.055,
                          ),

                          // Phone Edit Text
                          getDefaultTextFiled(
                              keyBoardType: TextInputType.number,
                              isBorder: false,
                              text: "Phone Number",
                              isGradient: true,
                              validatorFunc: validateInput,
                              controller: phoneEdit,
                              sufixIcon: Icons.phone_android_outlined,
                              inputType: TextInputType.name),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.055,
                          ),

                          getDefaultButton(text: "Send",
                              textColor:Color.fromRGBO(112, 112, 112, 1),
                              isShadow: true,
                              isGradinent: true,
                              function: (){
                            if(!_form.currentState!.validate()){
                              _form.currentState!.save();
                            }else{
                              Get.offAllNamed("/verify");
                            }

                              }),



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
    paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));


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
