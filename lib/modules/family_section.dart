import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

class FamilySection extends StatelessWidget {
  const FamilySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> list = [
      DropdownMenuItem(child: Text("Welcome 1"), value: "Welcome 1"),
      DropdownMenuItem(child: Text("Welcome 2"), value: "Welcome 2"),
      DropdownMenuItem(child: Text("Welcome 3"), value: "Welcome 3"),
      DropdownMenuItem(child: Text("Welcome 4"), value: "Welcome 4"),
    ];

    List<ImageProvider> imageList = [];
    imageList.add(AssetImage("assets/images/3d.jpg"));

    String? selectedValue = list[0].value;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color:Color.fromRGBO(242, 221, 128, 1),

              child: DropdownButton<String>(
                focusColor: Colors.red,

                value: selectedValue,
                items: list,
                onChanged: (String? value) {
                  print("Value  : ${value}");
                  // Handle dropdown item selection
                  if (value != null) {
                    selectedValue = value;
                  }
                },
              ),
            ),


            ImageView360(
              key: UniqueKey(),
              imageList: imageList,
              autoRotate: true,                                           //Optional
              rotationCount: 2,                                           //Optional
              rotationDirection: RotationDirection.anticlockwise,         //Optional
              frameChangeDuration: Duration(milliseconds: 50),            //Optional
              swipeSensitivity: 2,                                        //Optional
              allowSwipeToRotate: true,                                   //Optional
              onImageIndexChanged: (currentImageIndex) {                  //Optional
                print("currentImageIndex: $currentImageIndex");
              },
            )
          ],
        ),
      ),
    );
  }
}
