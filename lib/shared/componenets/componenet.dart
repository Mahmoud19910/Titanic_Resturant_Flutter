import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Row getIndicatorShap(int index){
  index=index+1;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 10,
        width: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Color.fromRGBO(240, 191, 108, 1),
            width: 2,
          ),
          color: index==1?Color.fromRGBO(240, 191, 108, 1):Color.fromRGBO(255, 255, 255, 1) ,
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        height: 10,
        width: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Color.fromRGBO(240, 191, 108, 1),
            width: 2,
          ),
          color: index==2?Color.fromRGBO(240, 191, 108, 1):Color.fromRGBO(255, 255, 255, 1) ,
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        height: 10,
        width: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Color.fromRGBO(240, 191, 108, 1),
            width: 2,
          ),
          color: index==3?Color.fromRGBO(240, 191, 108, 1):Color.fromRGBO(255, 255, 255, 1) ,
        ),
      ),
      SizedBox(
        width: 10,
      ),
    ],
  );
}

// Text Default
Widget getDefaultText({
  required String text,
  required double fontSize,
 String fontFamily="SF-Pro",
  required Color color,
   required bool setShadow,
  required FontWeight fontWeight

}
    ){
  return
  Text(
    text ,
    style: TextStyle(
        fontSize: fontSize,
        color: color,

        fontFamily:fontFamily,
        shadows:setShadow? [
          BoxShadow(
              color:Color.fromRGBO(0, 0, 0, 0.16),
              blurRadius:6,
              offset: Offset(0, 3)
          )
        ] : null,
      fontWeight: fontWeight


    ),
  );

}

// Button Graginent
Widget getGradinetButton(
{
  required String text,
  required bool isGradient,
  required Color color,
  double textSize=14,
  double height=50,
  double width=double.infinity,
   Function()? function,
  required bool isBorder,


}
    ){
  return  Expanded(
    child: Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              gradient: isGradient? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ Color.fromRGBO(242, 221, 128, 1),Color.fromRGBO(199, 143, 64, 1),],
              ) : null,
              borderRadius: BorderRadius.circular(5),
            border:isBorder? Border.all(color: Color.fromRGBO(199, 143, 64, 1) , width: 1) : null
          ),
          child: Center(child: getDefaultText(text: text, fontSize: textSize, color: color, setShadow: false, fontWeight: FontWeight.w500)),
        ),
        MaterialButton(
        onPressed: function,
            height: 50,
            minWidth: double.infinity,
            child: Text(text))
      ],
    ),
  );

}


//Edit Text
Widget getDefaultTextFiled(
{
  required String text,
  required TextEditingController controller,
  required IconData sufixIcon,
   bool showPass=false,
  required bool isGradient,
  required bool isBorder,
  required TextInputType keyBoardType,
  double width=double.infinity,
  required TextInputType inputType,
  String? Function(String?)? validatorFunc,
  Function()? showPassFunc,


}
)=>Container(
    width:width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Colors.white,
      border: isBorder?Border.all(color: Color.fromRGBO(0, 0, 0, 0.5)) : null,
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.5),
          blurRadius: 6,
          offset:Offset.fromDirection(1,1)
        ),
      ],
      gradient: isGradient? LinearGradient(
        begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(199, 143, 64, 1),Color.fromRGBO(242, 221, 128, 1)
          ]) : null,

    ),

    child: Padding(
      padding: EdgeInsets.only(left: 15,bottom: 1),
      child: TextFormField(
          controller: controller,
          validator: validatorFunc,
          obscureText: showPass,
          obscuringCharacter: '*',
          keyboardType: keyBoardType,

          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            suffixIcon: ColorFiltered(
              child: sufixIcon != null
                  ? InkWell(
                  onTap: showPassFunc, child: Icon(sufixIcon)) : null,
              colorFilter:
              ColorFilter.mode(Color.fromRGBO(62, 63, 61, 1), BlendMode.srcIn),
            ),
            hintStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'SF-Pro',
                color: Color.fromRGBO(112, 112, 112, 1)
            ),
          )
      ),
    )
);
String? validateInput(String? input) {
  if (input == null || input.isEmpty) {
    return 'Input cannot be empty';
  }
  return null;
}


// Under Line text
Widget getUnderLineText({
  required String text,
  required double fontSize,
  String fontFamily="SF-Pro",
  required Color color,
  required bool setShadow,
  required FontWeight fontWeight

}
    ){
  return
    Text(
      text ,
      style: TextStyle(
          fontSize: fontSize,
          decoration: TextDecoration.underline,
          color: color,
          fontFamily:fontFamily,
          shadows:setShadow? [
            BoxShadow(
                color:Color.fromRGBO(0, 0, 0, 0.16),
                blurRadius:6,
                offset: Offset(0, 3)
            )
          ] : null,
          fontWeight: fontWeight


      ),
    );

}


// Default Button
Widget getDefaultButton(
{
  required String text,
  required Color textColor,
 double textSize=16,
  required bool isShadow,
  required bool isGradinent,
   required Function() function,
}
    )
=>Container(
  width: double.infinity,
  height: 50,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    color: isGradinent? null : Colors.white,
   gradient:isGradinent? LinearGradient(
     begin: Alignment.topCenter,
     end: Alignment.bottomCenter,
     colors: [ Color.fromRGBO(199, 143, 64, 1),Color.fromRGBO(242, 221, 128, 1),]
   ) : null ,

    boxShadow: isShadow? [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.16),
        blurRadius: 6,
        offset: Offset(0,3)
      )
    ] : null,
  ),
  child: MaterialButton(
    onPressed:function,
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
        fontWeight: FontWeight.w500
      ),
    ),
  ) ,
);