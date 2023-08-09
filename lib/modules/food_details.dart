import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp/shared/componenets/componenet.dart';

class FoodDetails extends StatelessWidget {
  FoodDetails();

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(242, 221, 128, 1),
                    Color.fromRGBO(199, 143, 64, 1)
                  ])),
        ),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios_new),
        title: Text("بيتنزا بالخضار"),
      ),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Color.fromRGBO(0, 0, 0, 0.1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
                fit: BoxFit.fill,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
              ),
              SizedBox(
                height: 34.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                      height: 42,
                      width: 82,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.16)
                                , blurRadius: 6, offset: Offset(0, 3))
                          ]
                      ), child: TextFormField(
                    decoration: InputDecoration(hintText: "44"),
                    style: TextStyle(fontSize: 17),
                  )),

                  SizedBox(
                    width: 37,
                  ),

                  getDefaultText(
                      text: "العدد ",
                      fontSize: 22,
                      color: Colors.black,
                      setShadow: false,
                      fontWeight: FontWeight.w400),

                ],
              ),
              SizedBox(
                height: 34.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                      height: 42,
                      width: 82,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.16)
                                , blurRadius: 6, offset: Offset(0, 3))
                          ]
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "44",),
                        style: TextStyle(fontSize: 17),
                      )),

                  SizedBox(
                    width: 37,
                  ),

                  getDefaultText(
                      text: "السعر ",
                      fontSize: 22,
                      color: Colors.black,
                      setShadow: false,
                      fontWeight: FontWeight.w400),

                ],
              ),

              SizedBox(height: 45,),

              getDefaultText(
                  text: "إضافة ملاحظة ",
                  fontSize: 18,
                  color: Colors.black,
                  setShadow: false,
                  fontWeight: FontWeight.w700),

              SizedBox(height: 5,),

              Padding(
                padding: EdgeInsets.only(
                  right: 27,
                  left: 27,
                ),
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.15,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.16)
                            , blurRadius: 6, offset: Offset(0, 3))
                      ]

                  ),
                ),
              ),

              SizedBox(height: 15,),

              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(242, 221, 128, 1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.16)
                          , blurRadius: 6, offset: Offset(0, 3))
                    ]
                ),

                child: Center(child: getDefaultText(text: "إضافة للطلبات", fontSize: 18, color: Colors.black, setShadow: false, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
