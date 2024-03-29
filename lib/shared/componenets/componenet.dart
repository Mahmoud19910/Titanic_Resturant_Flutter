import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp/modles/meals.dart';

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
   IconData? sufixIcon,
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

Widget getMealsItemBuilder
({
  required double parentWidth,
  required double parentHeight,
  double photoRadius=25,
  required String netWorkImage,
  required String mealsName,
  required String price,
  bool borderRadiusDirection=true,
  Meals? addToFavorite,
  required Function() function,
  required Function() onClickItem,
  int? clickedItemIndex,



})=> InkWell(
  onTap: onClickItem,
  child:   Container(

  height: parentHeight,

  width: parentWidth,

  decoration: BoxDecoration(color: Colors.white,

  borderRadius: borderRadiusDirection ?BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30))

  :

  BorderRadius.only(topRight: Radius.circular(30), bottomLeft: Radius.circular(30)),

  boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.30),

  blurRadius: 6,

  offset: Offset(0, 6))

  ]),

  child: Padding(padding: const EdgeInsets.all(5.0),

  child: Row( children: [

  // صورة الوجبة

  Container(decoration: BoxDecoration(shape: BoxShape.circle,

  boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25),

  blurRadius: 6,

  offset: Offset(0, 3)),

  ]),

  child: CircleAvatar(

  radius: photoRadius,

  // Image radius

  backgroundImage:

  NetworkImage(netWorkImage),

  ),

  ),

  // اسم الوجبة

  Expanded(

  child: Padding(

  padding: const EdgeInsets.only(right: 5.0 , left: 5.0),

  child: Column(mainAxisAlignment:MainAxisAlignment.center,

  children: [Text(mealsName,

  maxLines: 2,

  style: TextStyle(fontSize: 14,

  fontWeight: FontWeight.w500,

  overflow: TextOverflow.ellipsis,

  ),

  ),

  Text("₪$price",

  style: TextStyle(fontSize: 14,

  fontWeight: FontWeight.w500),

  ),

  ],

  ),

  ),

  ),



  // الاضافة الى المفضلة

  InkWell(

    onTap: function,

    child:   Container(

    width: 35,

    height: 35,

    decoration: BoxDecoration(shape: BoxShape.circle,

    gradient: LinearGradient(

    colors: [Color.fromRGBO(242, 221, 128, 1),

    Color.fromRGBO(199, 143, 64, 1)

    ]),

    boxShadow: [BoxShadow(

    color: Color.fromRGBO(0, 0, 0, 0.25),

    blurRadius: 6,

    offset: Offset(0, 3)),

    ]),

    child: Padding(padding: const EdgeInsets.all(3.0),

    child: Container(width: 35,

    height: 35,

    decoration: BoxDecoration(

    shape: BoxShape.circle,

    color: Colors.white),

    child: Padding(

    padding: const EdgeInsets.all(2.0),

    child: Container(

    width: 35,

    height: 35,

    decoration: BoxDecoration(shape: BoxShape.circle,

    gradient: LinearGradient(

    colors: [

    Color.fromRGBO(242, 221, 128, 1),

    Color.fromRGBO(199, 143, 64, 1)])),

    child: (addToFavorite!.isAddTofav==true)? Icon(Icons.favorite_border_outlined, color: Colors.white,):Icon(Icons.favorite, color: Colors.white,),

    ),

    ),

    ),

    ),

    ),

  ),

  ],

  ),

  ),

  ),
);


Widget getFavoriteItemBuilder
    ({
  required double parentWidth,
  required double parentHeight,
  double photoRadius=25,
  required String netWorkImage,
  required String mealsName,
  required String price,
  bool borderRadiusDirection=true,

  required Function() function,
  int? clickedItemIndex,



})=> Container(
  height: parentHeight,
  width: parentWidth,
  decoration: BoxDecoration(color: Colors.white,
      borderRadius: borderRadiusDirection ?BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30))
          :
      BorderRadius.only(topRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
      boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.30),
          blurRadius: 6,
          offset: Offset(0, 6))
      ]),
  child: Padding(padding: const EdgeInsets.all(5.0),
    child: Row( children: [
// صورة الوجبة
      Container(decoration: BoxDecoration(shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 6,
              offset: Offset(0, 3)),
          ]),
        child: CircleAvatar(
          radius: photoRadius,
// Image radius
          backgroundImage:
          NetworkImage(netWorkImage),
        ),
      ),
// اسم الوجبة
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 5.0 , left: 5.0),
          child: Column(mainAxisAlignment:MainAxisAlignment.center,
            children: [Text(mealsName,
              maxLines: 2,
              style: TextStyle(fontSize: 14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
              Text("₪$price",
                style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),

// الحذف من المفضلة
      InkWell(
        onTap: function,
        child:   Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Color.fromRGBO(242, 221, 128, 1),
                    Color.fromRGBO(199, 143, 64, 1)
                  ]),
              boxShadow: [BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 6,
                  offset: Offset(0, 3)),
              ]),
          child: Padding(padding: const EdgeInsets.all(3.0),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(242, 221, 128, 1),
                          Color.fromRGBO(199, 143, 64, 1)])),
                child: Icon(Icons.cancel_outlined, color: Colors.white,),
              ),
            ),
          ),
        ),
      ),
    ],
    ),
  ),
);



Widget getSearch
    ({
  required double parentWidth,
  required double parentHeight,
  double photoRadius=25,
  required String netWorkImage,
  required String mealsName,
  required String price,
  bool borderRadiusDirection=true,

  required Function() function,
  int? clickedItemIndex,



})=> Container(
  height: parentHeight,
  width: parentWidth,
  decoration: BoxDecoration(color: Colors.white,
      borderRadius: borderRadiusDirection ?BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30))
          :
      BorderRadius.only(topRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
      boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.30),
          blurRadius: 6,
          offset: Offset(0, 6))
      ]),
  child: Padding(padding: const EdgeInsets.all(5.0),
    child: Row( children: [
// صورة الوجبة
      Container(decoration: BoxDecoration(shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 6,
              offset: Offset(0, 3)),
          ]),
        child: CircleAvatar(
          radius: photoRadius,
// Image radius
          backgroundImage:
          NetworkImage(netWorkImage),
        ),
      ),
// اسم الوجبة
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 5.0 , left: 5.0),
          child: Column(mainAxisAlignment:MainAxisAlignment.center,
            children: [Text(mealsName,
              maxLines: 2,
              style: TextStyle(fontSize: 14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
              Text("₪$price",
                style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),

    ],
    ),
  ),
);



Widget getOrderitems
    ({
  required double parentWidth,
  required double parentHeight,
  double photoRadius=25,
  required String netWorkImage,
  required String mealsName,
  required String price,
  bool borderRadiusDirection=true,

  required Function() function,
  int? clickedItemIndex,



})=> Container(
  height: parentHeight,
  width: parentWidth,
  decoration: BoxDecoration(color: Colors.white,
      borderRadius: borderRadiusDirection ?BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30))
          :
      BorderRadius.only(topRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
      boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.30),
          blurRadius: 6,
          offset: Offset(0, 6))
      ]),
  child: Padding(padding: const EdgeInsets.all(5.0),
    child: Row( children: [
// صورة الوجبة
      Container(decoration: BoxDecoration(shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 6,
              offset: Offset(0, 3)),
          ]),
        child: CircleAvatar(
          radius: photoRadius,
// Image radius
          backgroundImage:
          NetworkImage(netWorkImage),
        ),
      ),
// اسم الوجبة
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 5.0 , left: 5.0),
          child: Column(mainAxisAlignment:MainAxisAlignment.center,
            children: [Text(mealsName,
              maxLines: 2,
              style: TextStyle(fontSize: 14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
              Text("₪$price",
                style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),

    ],
    ),
  ),
);